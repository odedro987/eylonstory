package ui.components;

import core.Globals;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxShader;
import flixel.text.FlxBitmapText;

class ExpBar extends FlxTypedGroup<FlxSprite>
{
	var bar:FlxSprite;
	var text:FlxBitmapText;
	var expShader:ExpBarShader;
	var max:Float;
	var value:Float;

	public function new(x:Float, y:Float, width:Int, height:Int, max:Float = 100, segments:Int = 5)
	{
		super(2);
		value = 0;
		this.max = max;

		bar = new FlxSprite(x, y);
		bar.makeGraphic(width, height);
		expShader = new ExpBarShader(width, height, segments);
		bar.shader = expShader;
		add(bar);

		text = Globals.createBitmapText(x + width / 2 - 25, y + height / 2 - 2, value + " / " + max, 1.25);
		add(text);
	}

	public function updateMax(max:Float)
	{
		this.max = max;
		text.text = value + " / " + max;
	}

	public function updateValue(value:Float)
	{
		this.value = value;
		expShader.updateProgress(value / max);
		text.text = value + " / " + max;
	}
}

class ExpBarShader extends FlxShader
{
	@:glFragmentSource("
		#pragma header

        uniform float height;
        uniform float width;
        uniform float segments;
        uniform float progress;
		
		void main(void) {
			#pragma body

			vec2 uv = openfl_TextureCoordv;
			vec2 textureSize = openfl_TextureSize;

            vec2 pixpos = uv * textureSize;


            vec3 base = vec3(75.0) / 255.0;
            if (uv.x <= progress) {
                base = vec3(163.0, 201.0, 0.0) / 255.0;
            }
            vec3 darkBase = base - 10.0 / 255.0;
            vec3 lightBase = base + 60.0 / 255.0;

            // Base color
            gl_FragColor = vec4(base, 1.0);

            float segDiff = mod(pixpos.x, width / segments);
            if (segDiff >= -2.0 && segDiff <= 2.0) {
                gl_FragColor = vec4(lightBase, 1.0);
            }
            
            if (segDiff >= -1.0 && segDiff <= 1.0) {
                gl_FragColor = vec4(darkBase, 1.0);
            }

            // Shading
            for(float i = 10.0; i >= 0.0; i--) {
                if (pixpos.y >= height - 2.0 - i) {
                    gl_FragColor.rgb += 0.03; 
                }

                if (i > 5.0) {
                    if (pixpos.y <= (i - 5.0)) {
                        gl_FragColor.rgb += 0.03; 
                    } 
                }
            }
            
            // Borders
            if (pixpos.y >= height - 2.0){
                gl_FragColor = vec4(vec3(75.0 / 255.0), 1.0);
            }

            if (pixpos.y >= height - 1.0){
                gl_FragColor = vec4(vec3(195.0 / 255.0), 1.0);
            }
            
            if (pixpos.x >= width - 1.0){
                gl_FragColor = vec4(vec3(195.0 / 255.0), 1.0);
            }  
		}")
	public function new(width:Float, height:Float, segments:Int)
	{
		super();
		this.height.value = [height];
		this.width.value = [width];
		this.segments.value = [segments];
		this.progress.value = [0];
	}

	public function updateProgress(progress:Float)
	{
		this.progress.value = [progress];
	}
}

package {
  import flash.display.*
  import flash.geom.*
  import flash.events.*
	import flash.text.*
  import flash.filters.*

  import de.popforge.events.*
  import org.osflash.thunderbolt.Logger
  import caurina.transitions.Tweener

	import flash.external.ExternalInterface;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;

  // import org.casalib.util.NavigateUtil // For links

  public class Bouton extends MovieClip {
    
    public var _bg
    public var _label:TextField

    function Bouton() {
      addEventListener(Event.ADDED_TO_STAGE, init)
    }
    
    private function init(e:Event) {
      removeEventListener(Event.ADDED_TO_STAGE, init)
      addBackground()
      addLabel()
      adaptToScale()
      configureMousery()
    }
    
    private function configureMousery() {
			buttonMode = true; 
      mouseChildren = false;
			SimpleMouseEventHandler.register(this);
      addEventListener(SimpleMouseEvent.ROLL_OVER, rollOverHandler)
      addEventListener(SimpleMouseEvent.DRAG_OVER, rollOverHandler)
			addEventListener(SimpleMouseEvent.ROLL_OUT, rollOutHandler)
      addEventListener(SimpleMouseEvent.DRAG_OUT, rollOverHandler)
      addEventListener(SimpleMouseEvent.RELEASE, releaseHandler)
      addEventListener(SimpleMouseEvent.RELEASE_OUTSIDE, releaseHandler)
    }
    
		private function rollOverHandler(event:SimpleMouseEvent):void {
		}

		private function rollOutHandler(event:SimpleMouseEvent):void {
		}

		private function releaseHandler(event:SimpleMouseEvent):void {
		  var u = "http://www.fracturedatlas.org/donate?special=" + FlashVars.fetch.special + "&amount=" + MovieClip(this.parent)._equation._total_as_get_param
      // openUrl(u, NavigateUtil.WINDOW_BLANK)
      // openUrl(u)
			var request = new URLRequest(u);			
			var window = "_blank"
			navigateToURL(request, window);
		}
    
    private function addBackground() {
      _bg = new Shape()
      _bg.graphics.lineStyle(FlashVars.fetch.border_thickness, FlashVars.fetch.button_border_color)
      _bg.graphics.beginFill(FlashVars.fetch.button_color)
      _bg.graphics.drawRoundRect(0, 0, FlashVars.fetch.button_width, FlashVars.fetch.button_height, 10, 10)
      _bg.graphics.endFill()
      addChild(_bg)
      // addBevelToBackground()
    }
    
    private function addBevelToBackground() {
      var bgColor:uint     = 0xCCCCCC
      var size:uint        = 80
      var offset:uint      = 20
      var distance:Number  = 5
      var angleInDegrees:Number = 225; // opposite 45 degrees
      var colors:Array     = [0xFFFFFF, 0xCCCCCC, 0x000000]
      var alphas:Array     = [1, 0, 1]
      var ratios:Array     = [0, 128, 255]
      var blurX:Number     = 8
      var blurY:Number     = 8
      var strength:Number  = 2
      var quality:Number   = BitmapFilterQuality.HIGH
      var type:String      = BitmapFilterType.INNER
      var knockout:Boolean = true
      var g = new GradientBevelFilter(distance, angleInDegrees, colors, alphas, ratios, blurX, blurY, strength, quality, type, knockout)
      _bg.filters = [g]
    }
    
    private function addLabel() {
			var format:TextFormat = new TextFormat()
		  format.font = new LucidaGrandeBold().fontName
			format.color = FlashVars.fetch.button_text_color
			format.size = FlashVars.fetch.button_text_size
			format.align = "center"
			format.bold = true
			format.letterSpacing = -.5

		  // Text
		  var l = _label = new TextField()
      l.autoSize = TextFieldAutoSize.LEFT
		  l.selectable = false
			l.multiline = true
			l.wordWrap = false
      l.embedFonts = true
			l.defaultTextFormat = format
			l.htmlText = FlashVars.fetch.button_text
			addChild(l)
			
      l.x = (_bg.width-l.width)/2
      l.y = (_bg.height-l.height)/2
    }
    
    public function adaptToScale() {
      x = stage.stageWidth - width - FlashVars.fetch.button_margin_right
      y = (stage.stageHeight-height)/2
    }
    
  }
}
package {
  import flash.display.*
  import flash.geom.*
  import flash.events.*
	import flash.text.*

  import org.osflash.thunderbolt.Logger
  import caurina.transitions.Tweener

  public class TriathlonWidget extends MovieClip {
    
    public var _bg:Shape
    public var _logo:Logo
    public var _title:TextField
    public var _equation
    public var _button
  
    function TriathlonWidget() {
      FlashVars.process(this)
      configureStage()
      addBackground()
      addLogo()
      addTitle()
      addEquation()
      addButton()
      appear()
    }
    
    private function appear() {
      if (FlashVars.fetch.fade_in_enabled) {
        alpha = 0
        Tweener.addTween(this, {alpha:1, time:FlashVars.fetch.fade_in_time, transition:"easeInCubic"})
      }
    }
    
    private function addBackground() {
      var margin = 2
      _bg = new Shape()
      _bg.graphics.lineStyle(FlashVars.fetch.border_thickness, FlashVars.fetch.border_color)
      _bg.graphics.beginFill(FlashVars.fetch.background_color)
      _bg.graphics.drawRoundRect(0, 0, stage.stageWidth-(margin*2), stage.stageHeight-(margin*2), FlashVars.fetch.background_corner_size, FlashVars.fetch.background_corner_size)
      _bg.graphics.endFill()
      addChild(_bg)
      _bg.x = _bg.y = margin // So it doesn't get cropped on the edge of the SWF canvas
    }

    private function addLogo() {
      _logo = new Logo()
      addChild(_logo)
      _logo.x = FlashVars.fetch.logo_padding_left
      _logo.y = _bg.y + (_bg.height-_logo.height)/2 // center vertically over bg
    }
    
    private function addTitle() {
      // Font
			var format:TextFormat = new TextFormat()
		  format.font = new Trebuchet().fontName
			format.color = FlashVars.fetch.title_color
			format.size = FlashVars.fetch.title_font_size
			format.bold = true

		  // Text
		  var l = _title = new TextField()
      l.autoSize = TextFieldAutoSize.LEFT
		  l.selectable = false
			l.multiline = false
			l.wordWrap = false
      l.embedFonts = true
      l.width = FlashVars.fetch.settings_list_width
			l.defaultTextFormat = format
			l.htmlText = FlashVars.fetch.title_text
			addChild(l)

      l.x = _logo.x + _logo.width + FlashVars.fetch.logo_padding_right
      l.y = _bg.y + FlashVars.fetch.title_padding_top
    }
    
    private function addEquation() {
      _equation = new Equation()
      addChild(_equation)
      _equation.x = _logo.x + _logo.width + FlashVars.fetch.logo_padding_right
      // Under title if there is one.. otherwise use top edge of _bg
      _equation.y = (FlashVars.fetch.show_title) ? _title.y + _title.height : _bg.y
      _equation.y += FlashVars.fetch.equation_padding_top
    }
    
    private function addButton() {
      _button = new Bouton()
      addChild(_button)
    }
    
		private function configureStage() {
      stage.align = StageAlign.TOP_LEFT
      stage.scaleMode = StageScaleMode.NO_SCALE
		}

  }
}
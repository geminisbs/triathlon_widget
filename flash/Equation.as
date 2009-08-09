package {
  import flash.display.*
  import flash.geom.*
  import flash.events.*
	import flash.text.*

  import org.osflash.thunderbolt.Logger
  import caurina.transitions.Tweener
  import agi.utils.Format // http://agitatedobserver.com/as3-currency-formatter/

  public class Equation extends MovieClip {
    
    public var _sentence_start:TextField
    public var _input:TextField
    public var _sentence_end:TextField
    public var _total:TextField
    public var _fmt1:TextFormat
    public var _fmt2:TextFormat
    public var _total_as_get_param:String
  
    function Equation() {
      addEventListener(Event.ADDED_TO_STAGE, init)
    }
    
    private function init(e:Event) {
      removeEventListener(Event.ADDED_TO_STAGE, init)

      defineTextFormats()
      addSentenceStart()
      addInput()
      addSentenceEnd()
      addTotal()
      adaptToScale()
      updateTotal()
    }
    
    private function defineTextFormats() {
			_fmt1 = new TextFormat()
		  _fmt1.font = new LucidaGrande().fontName
			_fmt1.color = FlashVars.fetch.sentence_text_color
			_fmt1.size = FlashVars.fetch.sentence_text_size
			
			_fmt2 = new TextFormat()
		  _fmt2.font = new LucidaGrande().fontName
			_fmt2.color = FlashVars.fetch.total_text_color
			_fmt2.size = FlashVars.fetch.total_text_size
			_fmt2.bold = true
			_fmt2.letterSpacing = -1
    }

		// "103.2 miles at $"     
    private function addSentenceStart() {
		  var ss = _sentence_start = new TextField()
      ss.autoSize = TextFieldAutoSize.LEFT
      ss.embedFonts = true
			ss.defaultTextFormat = _fmt1
			ss.htmlText = FlashVars.fetch.total_miles + " miles at $"
			addChild(ss)      
    }

    private function addInput() {
      var i = _input = new TextField()
      i.type = TextFieldType.INPUT
      i.width = 40
      i.height = 20
      i.background = true
      i.backgroundColor = FlashVars.fetch.input_background_color
      i.border = true
      i.borderColor = FlashVars.fetch.input_border_color
      i.embedFonts = true
			i.defaultTextFormat = _fmt1
			i.htmlText = String(FlashVars.fetch.default_donation_per_mile)
      addChild(i)
      i.addEventListener(Event.CHANGE,onTextInput)
    }

	  // "per mile = "   
    private function addSentenceEnd() {
		  var se = _sentence_end = new TextField()
      se.autoSize = TextFieldAutoSize.LEFT
      se.embedFonts = true
			se.defaultTextFormat = _fmt1
			se.htmlText = "per mile ="
			addChild(se)
    }
    
    // text field for dynamic total
    private function addTotal() {
		  var t = _total = new TextField()
      t.autoSize = TextFieldAutoSize.LEFT
      t.embedFonts = true
			t.defaultTextFormat = _fmt2
			t.htmlText = "000"
			addChild(t)
    }
    
    public function adaptToScale() {
      _sentence_start.x = 0
      _input.x = _sentence_start.x + _sentence_start.width + FlashVars.fetch.equation_sentence_spacing
      _sentence_end.x = _input.x + _input.width + FlashVars.fetch.equation_sentence_spacing
      _total.x = _sentence_end.x + _sentence_end.width + FlashVars.fetch.equation_sentence_spacing

      // bump everything but total down a bit to center vertically with total
      var bump = (FlashVars.fetch.total_text_size-FlashVars.fetch.sentence_text_size)/2
      _sentence_start.y = _input.y = _sentence_end.y = _sentence_start.y + bump
    }

    public function onTextInput(e:Event) {
       updateTotal()
    }
    
    private function updateTotal() {
      var _format:Format =  new Format();
      var amount = FlashVars.fetch.total_miles * Number(_input.text)
      if (isNaN(amount)) amount = 0
      _total_as_get_param = String(_format.currency(amount,2,"")) // no dollar sign
      _total.htmlText = String(_format.currency(amount,2,"$"))
    }
    
  }
}
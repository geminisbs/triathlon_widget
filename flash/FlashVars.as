package {
  
  import flash.display.*
  import flash.events.*
  import org.osflash.thunderbolt.Logger
  
  public class FlashVars {
    
    public static var fetch:Object = [];

    public function FlashVars() {
      trace ("FlashVars is a static class and should not be instantiated.")
    }

    public static function process(document_root) {
      var flash_vars = LoaderInfo(MovieClip(document_root).root.loaderInfo).parameters
			
			// Set string defaults
			var strings:Object = {
        title_text:"Support the Triathlon Team!",
        button_text:"DONATE\nNOW",
        special:"Triathlon+Team" // the value for the outgoing 'special' GET param
			}

			// Set boolean defaults
      var booleans:Object = {
        show_title:true,
        fade_in_enabled:true
			}

			// Set number defaults
      var numbers:Object = {
        fade_in_time:1,
        background_corner_size:2,
        background_color:0xF4F0E4,
        
        border_color:0xC7B299,
        border_thickness:1,
        
        button_color:0xEA8018,
        button_border_color:0xC6640C,
        button_text_color:0xFFFFFF,
        button_text_size:14,
        button_width:80,
        button_height:55,
        button_corner_size:2,
        button_margin_right:5,
        
        logo_padding_left:10,
        logo_padding_right:10,
        title_font_size:18,
        title_color:0x265287,
        title_padding_top:10,

        // equation
        equation_padding_top:5,
  			sentence_text_color:0x7A644D, // brown
  			sentence_text_size:13,
        total_text_color:0xC6640C, // dark orange
  			total_text_size:16,
  			input_background_color:0xFFFFFF,
        input_border_color:0xC7B299, // brown
  			total_miles:102.3,
  			default_donation_per_mile:1, // in dollars
  			equation_sentence_spacing:1
      }

      var temp:Object = [];
      
			// Load any received FlashVars
      for (var k in flash_vars) {
        temp[k] = flash_vars[k];
      }

      // Load String, Boolean, Number defaults and
      // coerce non-strings into their appropriate datatype
			for (k in strings) {
  			if (temp[k] == undefined) temp[k] = strings[k]
			}

			for (k in booleans) {
  			if (temp[k] == undefined) temp[k] = booleans[k]
        temp[k] = (temp[k] == "true" || temp[k] == "1"|| temp[k] == 1) ? true : false
			}
			
			for (k in numbers) {
  			if (temp[k] == undefined) temp[k] = numbers[k]
        temp[k] = Number(temp[k])
			}
			
			// Transfer massaged values over to 'fetch' container
			for (k in temp) {
			  FlashVars.fetch[k] = temp[k]
      }

    }
        
  }
}
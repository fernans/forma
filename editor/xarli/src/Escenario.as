package 
{
	import fl.data.DataProvider;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class Escenario extends MovieClip
	{
		private var dp:DataProvider = new DataProvider();
		
		private var _xml:XML;
		
		public function Escenario(xml:XML)
		{
			_xml = xml;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(e:Event){
			combo.dataProvider = dp;
			combo.addEventListener(Event.CHANGE, onChange);
			combo.selectedIndex = 1;			
			for(var i:int = 0; i<_xml.escenas.escena.length(); i++){
				dp.addItem({label:_xml.escenas.escena[i].@nombre, value:_xml.escenas.escena[i].@id, urlimagen:_xml.escenas.escena[i].@imagen});
			}
			onChange();
			addEventListener(FocusEvent.FOCUS_IN, onClick);
		}
		
		private function onChange(e:Event = null){
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest(combo.selectedItem.urlimagen);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.load(mRequest);
		}
		
		function onCompleteHandler(event:Event)
		{
			while(imagen.numChilden > 0){
				imagen.removeChildAt(0);
			}
			var objeto:Bitmap = event.target.loader.content;
			event.target.loader.unload();
			objeto.smoothing = true;
			objeto.width = 283;
			objeto.scaleY = objeto.scaleX;
			imagen.addChild(objeto);			
		}
		
		function onClick(event:Event)
		{
			MovieClip(root).entorno.seleccionarEscenario(this);
			trace(combo.selectedItem.value);
		}
		
		public function aXML(){
			var cadena:String = '';
			cadena += '<escenario url="'+_xml.@ruta+'" color="' + combo.selectedItem.value +'" />';
			cadena += '<camara id="'+_xml.camaras.camara[0].@id+'" animacion="1" />';
			return cadena; 
		}
	}
}
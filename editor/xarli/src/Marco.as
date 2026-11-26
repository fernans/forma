package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class Marco extends MovieClip
	{
		public var nombre;
		public var id;
		public var imagenurl;
		
		public function Marco(_nombre:String, _id:String, _imagenurl:String){
			nombre = _nombre;
			id = _id;
			imagenurl = _imagenurl;
			
			var mLoader:Loader = new Loader();
			var mRequest:URLRequest = new URLRequest(imagenurl);
			mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
			mLoader.load(mRequest);
			
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		function onCompleteHandler(event:Event)
		{
			var objeto:Bitmap = event.target.loader.content;
			event.target.loader.unload();
			objeto.smoothing = true;
			objeto.width = 153;
			objeto.scaleY = objeto.scaleX;
			imagen.addChild(objeto);			
		}
		
		function onClick(event:Event)
		{
			MovieClip(root).entorno.seleccionarMarco(this);
		}
		
		public function aXML(){
			var cadena:String = '';
			cadena += '<marco id="'+id+'" />';
			return cadena; 
		}
	}
}
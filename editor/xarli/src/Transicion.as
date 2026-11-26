package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	public class Transicion extends MovieClip
	{
		public var nombre:String;
		public var id:String;
		public var imagenurl:String;
		
		public function Transicion(_nombre:String, _id:String, _imagenurl:String){
			nombre = _nombre;
			id = _id;
			imagenurl = _imagenurl;
			
			this.alpha = 0.5;
			
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
			objeto.width = 112;
			objeto.scaleY = objeto.scaleX;
			imagen.addChild(objeto);			
		}
		
		function onClick(event:Event)
		{
			MovieClip(root).editor.seleccionarTransicion(this.id);
		}
	}
}
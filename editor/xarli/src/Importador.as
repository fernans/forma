package {

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.events.IOErrorEvent;
	
	public class Importador
	{
		private var np:NativeProcess;
		private var padre:MovieClip;
		private var fichero:File;
		private var tempFolder:File;
		private var tempFile:File;
		private var tempFileAlt:File;
		private var correcto:Boolean = false;
		private var salida:String;
		private var tipo:String = "";
	
		public function Importador(_fichero:File, _padre:MovieClip)
		{
			padre = _padre;
			trace(padre);
			
			fichero = _fichero;
			padre.traceT(fichero.nativePath);
			np = new NativeProcess();
			
			if(!NativeProcess.isSupported){
				padre.traceT("Entorno no soportado");
				return;
			}
			
			np.addEventListener(NativeProcessExitEvent.EXIT, done);
			np.addEventListener(Event.STANDARD_ERROR_CLOSE, error);
			
			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var args:Vector.<String> = new Vector.<String>();
			
			//*.mpeg;*.mpg;*.avi;*.mov;*.ogm;*.ogg
			switch(fichero.extension.toLowerCase()){
				case 'ppt':
				case 'pps':
					tipo = "powerpoint";
					padre.traceT("Importando presentación");
					np.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputPPT);
					info.executable = File.applicationDirectory.resolvePath("converters/fromPpt.exe");
					
					tempFolder = File.createTempDirectory();
					args.push(fichero.nativePath);
					args.push(tempFolder.nativePath);
					//args.push(ancho);
					//args.push(alto);
	
					info.arguments = args;
					
					//Arrancamos
					np.start(info);
					break;
				case 'tif':
				case 'tiff':
				case 'tga':
				case 'bmp':
				case 'jpg':
				case 'jpeg':
				case 'gif':
				case 'png':
					tipo = "imagen";
					padre.traceT("Importando imagen");
					np.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputIMG);
					info.executable = File.applicationDirectory.resolvePath("converters/fromImage.exe");
					
					//Argumentos
					tempFile = File.createTempFile();
					args.push(fichero.nativePath);
					args.push(tempFile.nativePath);
					//args.push(ancho);
					//args.push(alto);
					info.arguments = args;
					
					//Arrancamos
					np.start(info);
					break;
				case 'mpeg':
				case 'mpg':
				case 'avi':
				case 'mov':
				case 'ogm':
				case 'ogg':
					tipo = "video";
					padre.traceT("Importando video");
					
					// No se usa
					//np.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputVIDEO);
					info.executable = File.applicationDirectory.resolvePath("converters/fromVideo.exe");
					info.workingDirectory = File.applicationDirectory.resolvePath("converters/");

					//Argumentos
					tempFile = new File(File.createTempDirectory().nativePath+File.separator+fichero.name.split(".")[0]+".ogg"); //File.createTempFile();
					padre.traceT(tempFile.nativePath);

					args.push('"'+fichero.nativePath+'"');
					args.push('"'+tempFile.nativePath+'"');
					args.push("1024");
					args.push("1024");
					padre.traceT("converters/fromVideo.exe " + '"'+fichero.nativePath+'"' + " " + '"'+tempFile.nativePath+'" 1024 1024');

					//args.push(anchorecorte);
					//args.push(altorecorte);
					info.arguments = args;
					
					//Arrancamos
					np.start(info);
					break;
				default:
					padre.traceT("Fichero no reconocido<br />Extensiones válidas: ppt,pps,tif,tiff,tga,bmp,jpg,jpeg,gif,png,mpeg,mpg,avi,mov,ogm,ogg");
			}
		}
		
		private function done(event:NativeProcessExitEvent):void
		{
			padre.traceT("Codigo de salida:" + event.exitCode);
			
			// El video devuelve 1 pero no genera salida, lo manejamos aqui
			if(event.exitCode == 1 && tipo == "video"){
				correcto = true;
				
				//trace(File.applicationDirectory.resolvePath("converters/video.jpg").nativePath);
				MovieClip(padre).diapos.nuevaDiapositiva(File.applicationDirectory.resolvePath("converters/video.jpg").nativePath,null,tempFile.nativePath);
				//crearMiniatura();
			} 
			
			// La miniatura lo mismo
			/*
			if(event.exitCode == 1 && tipo == "miniatura"){
				correcto = true;
				MovieClip(padre).diapos.nuevaDiapositiva(tempFileAlt.nativePath,null,tempFileAlt.nativePath);				
			}
			*/
			
			// Avisamos si todo ha acabado ok
			if(correcto)
				padre.traceT("Importación correcta");
			else 
				padre.traceT("Fallo al importar");
		}
		
		private function error(event:Event):void
		{
			padre.traceT("Cerrado el proceso");
		}
		
		private function onOutputPPT(event:ProgressEvent):void
		{
			padre.traceT("onOutputPPT");
			salida = np.standardOutput.readUTFBytes(np.standardOutput.bytesAvailable);
			padre.traceT("Salida:" + salida);
			if(find(salida," Images succefully saved!")){
				//Powerpoint
				var num:int = parseInt(salida.split(" Images succefully saved!")[0]);
				if(num > 0){
					for(var i:int = 0; i < num; i++){
						MovieClip(padre).diapos.nuevaDiapositiva(tempFolder.nativePath+File.separator+(i+1)+".JPG");
					}
					correcto = true;
					padre.traceT(num + " fotogramas creados!");
				}
			}
		}
		private function onOutputIMG(event:ProgressEvent):void
		{
			padre.traceT("onOutputIMG");
			salida = np.standardOutput.readUTFBytes(np.standardOutput.bytesAvailable);
			padre.traceT("Salida:" + salida);
			
			if(find(salida,"image successfully saved! : ")){
				padre.traceT("Imagen Creada!");
				MovieClip(padre).diapos.nuevaDiapositiva(tempFile.nativePath);
				correcto = true;
			}			
		}
		
		//ffmpeg  -itsoffset -4  -i test.avi -y -vcodec mjpeg -vframes 1 -an -f rawvideo -s 1024x1024 test.jpg
		private function crearMiniatura():void
		{
			padre.traceT("Creando Miniatura");
			
			// Reseteamos el tipo
			tipo = "miniatura";	
			
			// Regeneramos el NativeProcess
			np = new NativeProcess();
			np.addEventListener(NativeProcessExitEvent.EXIT, done);
			np.addEventListener(Event.STANDARD_ERROR_CLOSE, error);
			
			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			var args:Vector.<String> = new Vector.<String>();
			
			// No se usa
			np.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputTHUMBNAIL);
			np.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onOutputTHUMBNAIL);
			np.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onError);
			np.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onError);
			np.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR,onError);
			info.executable = File.applicationDirectory.resolvePath("converters/ffmpeg.exe");
			info.workingDirectory = File.applicationDirectory.resolvePath("converters/");
			
			//Argumentos
			tempFileAlt = new File(File.createTempDirectory().nativePath+File.separator+fichero.name.split(".")[0]+".jpg"); //File.createTempFile();
			padre.traceT(tempFile.nativePath);
			
			//ffmpeg  -itsoffset -4  -i test.avi -y -vcodec mjpeg -vframes 1 -an -f rawvideo -s 1024x1024 test.jpg
			args.push("-itsoffset");
			args.push("-4");
			args.push("-i");
			args.push('"'+fichero.nativePath+'"'); // El video output
			args.push("-y");
			args.push("-vcodec");
			args.push("mjpeg");
			args.push("-vframes");
			args.push("1");
			args.push("-an");
			args.push("-f");
			args.push("rawvideo");
			args.push("-s");
			args.push('"1024x1024"');
			args.push('"'+tempFileAlt.nativePath+'"'); //La imagen de salida
			
			/*
			for(var i:int = 0; i < args.length; i++){
				padre.traceT(args[i]);
			}
			*/
			padre.traceT('converters/ffmpeg.exe -itsoffset -4  -i "'+tempFile.nativePath+'" -y -vcodec mjpeg -vframes 1 -an -f rawvideo -s 1024x1024 "'+tempFileAlt.nativePath+'"');
			
			info.arguments = args;

			//Arrancamos
			np.start(info);			
		}
		
		private function find(cadena:String, trozo:String){
			return (cadena.indexOf(trozo) >= 0);
		}

		// Finalmente no es necesario xq se mira en el retorno
		/*
		private function onOutputVIDEO(event:ProgressEvent):void
		{
			padre.traceT("onOutputVIDEO");
			salida = np.standardOutput.readUTFBytes(np.standardOutput.bytesAvailable);
			padre.traceT("Salida:" + salida);
			if(find(salida,"frame=") && find(salida,"fps=") && find(salida,"time=")){
				padre.traceT("Video Creado!");
				correcto = true;
				//crearMiniatura();
				//Video
				//Devuelve frame= , fps= , q= , time=
			}			
		}
		*/

		function onError(evt:IOErrorEvent):void {
			//Any error in writing input/output pipes will trigger this function
			trace(evt.text);
		}
		// Finalmente no es necesario xq se mira en el retorno
		
		private function onOutputTHUMBNAIL(event:ProgressEvent):void
		{
			padre.traceT("onOutputTHUMBNAIL");
			salida = np.standardOutput.readUTFBytes(np.standardOutput.bytesAvailable);
			padre.traceT("Salida:" + salida);
			/*
			if(find(salida,"video:") && find(salida,"audio:") && find(salida,"headers:")){
				padre.traceT("Miniatura Creada!");
				correcto = true;
				MovieClip(padre).diapos.nuevaDiapositiva(tempFileAlt.nativePath,null, tempFileAlt.nativePath);
			}
			*/
		}
		
	}
}
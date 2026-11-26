# Forma (3D presentation platform: editor, player and converters)

> **This project is shared ONLY for educational purposes. Its use, direct or derived, for professional or economic purposes is not permitted.**

Forma is a legacy interactive 3D presentation system: an Adobe AIR/Flash authoring editor (`editor/xarli`), a Shiva 3D / S3DClient runtime with sample scenarios (`player/escenarios`), and helper converters for images, video and PowerPoint (`conversores`). It is preserved here as a historical educational resource only.

For security reasons, some parts of the project may have been edited or removed. Private signing material, a ZIP that embedded it, build folders containing a platform app secret, budget documents, obsolete backups and copies of other projects are excluded. Third-party headers, authorship notices, URLs, analytics IDs and local paths were deliberately left unchanged.

## Requirements / How to run

- Editor: ActionScript 3 and Adobe AIR 2.0 (`editor/xarli/Forma-app.xml`) with Flash Player; `Forma.fla` is the authoring file and `Forma.swf` the published one; Windows packages `Forma.air` and `Forma.exe` are included.
- Player: Shiva 3D / S3DClient runtime for Windows (`player.exe`, `player.bat`). Sample scenarios live in `player/escenarios/circulos` and `player/escenarios/ciudad`; the shared engine is in `player/escenarios/_engine_`. Scene data uses `.stk`, `.ste`, `.xml`, `.xsl`, `.lua` and `.cfg` files, with 3ds Max source assets under the `ciudad max` folders.
- Mobile preview: `player/preview_ciudad_shiva/ciudad_Airplay.s3dxproj/ciudad.mkb` targets Marmalade 5.0 / s3e. Generated build and deployment folders are not included.
- Converters: Code::Blocks C/C++ projects (`*.cbp`) using FFmpeg 0.6.1, FreeImage and Microsoft Office / Ppt2FlashSdk interop. Ready-to-run Windows executables are in `conversores/releases/`.
- To inspect the demos on Windows, open a scenario folder under `player/escenarios` and launch `player.bat` or `player.exe`. To edit the authoring tool, use a compatible Flash / AIR toolchain. No modern build step is required to read the sources.

## Large assets

`player/escenarios/ciudad/ciudad max/camaras_02.mov` (122.54 MB) is not stored in this repository because it exceeds the 100 MB per-file limit. Download `forma-assets.zip` from the **Releases** tab and extract it into the project root, preserving the folder structure (`player/escenarios/ciudad/ciudad max/camaras_02.mov`).

## Excluded material

- Reference copies / obsolete backups: `_OLD_/`, `hd_vicente/` (an old full copy of this project), `docs/juntaAndalucia/` (a copy of another cubensis project), `player/Backup_old/`, `player/escenarios/Copia de _engine_/`, plus any other `Copia de ...` folder.
- Budget and commercial documents: `docs/presupuesto/` and the documents under `hd_vicente/cubensis/`.
- Signing material: `editor/xarli/mycert pass 1234.p12` and `editor/xarli/Forma.zip`, which contained that certificate. Generated build logs under `build_ciudad_vc9/` containing a platform app secret were also excluded.
- Third-party libraries and headers (GreenSock, FreeImage, FFmpeg, ppt2flashsdk and similar) are kept with their original headers and authorship notices.

## Disclaimer

The software is provided "as is", without warranty of any kind. No liability is accepted for any errors or damages resulting from its use.

> **AI training**: the use of the content of this repository (code, assets, documentation) to train or fine-tune machine learning models or AI systems is expressly **not permitted**. All of the repository is licensed under CC-BY-NC-4.0 (see the `LICENSE` file).

## License

Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0). See `LICENSE` for the full legal text.

---

# Forma (plataforma de presentaciones 3D: editor, player y conversores)

> **Este proyecto se comparte SOLO con valor educativo. No está permitido su uso (directo o derivado) para fines profesionales o económicos.**

Forma es un sistema antiguo de presentaciones interactivas 3D: un editor de autoría en Adobe AIR/Flash (`editor/xarli`), un runtime Shiva 3D / S3DClient con escenarios de ejemplo (`player/escenarios`) y conversores auxiliares de imágenes, vídeo y PowerPoint (`conversores`). Se conserva únicamente como recurso histórico y educativo.

Por motivos de seguridad, es posible que algunas partes se encuentren editadas o eliminadas. Se han excluido el material de firma privada, un ZIP que lo contenía, las carpetas de compilación con un secreto de plataforma, los documentos presupuestarios, las copias obsoletas y las copias de otros proyectos. Las cabeceras de terceros, las notas de autoría, las URLs, los identificadores de analítica y las rutas locales se han dejado deliberadamente sin cambios.

## Requisitos / Cómo ejecutar

- Editor: ActionScript 3 y Adobe AIR 2.0 (`editor/xarli/Forma-app.xml`) con Flash Player; `Forma.fla` es el archivo de autoría y `Forma.swf` el publicado; se incluyen los paquetes de Windows `Forma.air` y `Forma.exe`.
- Player: runtime Shiva 3D / S3DClient para Windows (`player.exe`, `player.bat`). Los escenarios de ejemplo están en `player/escenarios/circulos` y `player/escenarios/ciudad`; el motor compartido está en `player/escenarios/_engine_`. Los datos de escena usan archivos `.stk`, `.ste`, `.xml`, `.xsl`, `.lua` y `.cfg`, con fuentes 3ds Max en las carpetas `ciudad max`.
- Vista previa móvil: `player/preview_ciudad_shiva/ciudad_Airplay.s3dxproj/ciudad.mkb` apunta a Marmalade 5.0 / s3e. Las carpetas generadas de compilación y despliegue no se incluyen.
- Conversores: proyectos C/C++ de Code::Blocks (`*.cbp`) que usan FFmpeg 0.6.1, FreeImage e interoperabilidad con Microsoft Office / Ppt2FlashSdk. Los ejecutables de Windows ya compilados están en `conversores/releases/`.
- Para ver las demos en Windows, abre una carpeta de escenario dentro de `player/escenarios` y ejecuta `player.bat` o `player.exe`. Para editar la herramienta de autoría, usa un entorno compatible con Flash / AIR. No hace falta un paso de compilación moderno para leer las fuentes.

## Archivos grandes

`player/escenarios/ciudad/ciudad max/camaras_02.mov` (122,54 MB) no se incluye en este repositorio por superar el límite de 100 MB por archivo. Descarga `forma-assets.zip` desde la pestaña **Releases** y extráelo en la raíz del proyecto, manteniendo la estructura de carpetas (`player/escenarios/ciudad/ciudad max/camaras_02.mov`).

## Material excluido

- Copias de referencia / respaldos obsoletos: `_OLD_/`, `hd_vicente/` (una copia completa antigua de este proyecto), `docs/juntaAndalucia/` (copia de otro proyecto de cubensis), `player/Backup_old/`, `player/escenarios/Copia de _engine_` y cualquier otra carpeta `Copia de ...`.
- Documentos presupuestarios y comerciales: `docs/presupuesto/` y los documentos bajo `hd_vicente/cubensis/`.
- Material de firma: `editor/xarli/mycert pass 1234.p12` y `editor/xarli/Forma.zip`, que contenía dicho certificado. También se excluyeron los logs de compilación bajo `build_ciudad_vc9/` que contenían un secreto de plataforma.
- Las librerías y cabeceras de terceros (GreenSock, FreeImage, FFmpeg, ppt2flashsdk y similares) se conservan con sus cabeceras y notas de autoría originales.

## Aviso

El software se proporciona «tal cual», sin ningún tipo de garantía. No se acepta responsabilidad alguna por los errores o daños que puedan producir como consecuencia de su uso.

> **Entrenamiento de IA**: no se permite expresamente el uso del contenido de este repositorio (código, recursos, documentación) para entrenar o ajustar (*fine-tune*) modelos de aprendizaje automático o sistemas de IA. Todo el repositorio se publica con licencia CC-BY-NC-4.0 (ver el archivo `LICENSE`).

## Licencia

Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0). Consulta `LICENSE` para el texto legal completo.

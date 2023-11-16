@echo off
::This file was created automatically by crosside to compile with C51.
C:
cd "\Source\DE2_8052\Cmon51\examples\"
"C:\Source\call51\Bin\c51.exe" --use-stdout  "C:\Source\DE2_8052\Cmon51\examples\Tetris52.c"
if not exist hex2mif.exe goto done
if exist Tetris52.ihx hex2mif Tetris52.ihx
if exist Tetris52.hex hex2mif Tetris52.hex
:done
echo done
echo Crosside_Action Set_Hex_File C:\Source\DE2_8052\Cmon51\examples\Tetris52.hex

:: Para no tener que abrir dosbox, montar unidad y linkear los archivos, EJECUTAR este .BAT

@echo off
:: Para poder hacer uso del comando 'dosbox', el programa debe estar agregado al path del sistema
start dosbox -c "mount c ..\sortNumbers" -c "c:" -c "link main.obj" -c "exit"
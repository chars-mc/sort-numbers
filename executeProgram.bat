@echo off
:: Para poder hacer uso del comando 'dosbox', el programa debe estar agregado al path del sistema

start dosbox -c "mount c ..\sortNumbers" -c "c:" -c "main" -c "exit"
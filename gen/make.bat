@echo off
:build

call mason make widget_template -c .\configs\test1_config.json --on-conflict overwrite

@REM xcopy /Y .\test1_widget\test1_component.dart C:\Users\komil\Documents\GitHub\nocode\creatego_packages\packages\creatego_widgetbook\lib\src\blocks\cbt\
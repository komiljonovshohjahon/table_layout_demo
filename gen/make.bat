@echo off
:build

call mason make widget_template -c .\widget_configs\config.json --on-conflict overwrite

@REM xcopy /Y .\test_widget\test_component.dart C:\Users\komil\Documents\GitHub\nocode\creatego_packages\packages\creatego_widgetbook\lib\src\blocks\cbt\
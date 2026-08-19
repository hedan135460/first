@echo off
chcp 65001 >nul
title Blog Publish - Blog Publish
powershell -NoProfile -ExecutionPolicy Bypass -File "D:\myblog\publish.ps1"
# web-timeline  
ДПВ по R: Лабораторная по сбору данных из выдачи поисковой системы.  
  
## Цель работы  
Реализовать принцип, описанный в выпуске "Хронология будущего" онлайн комикса «xkcd3». Автор комикса проанализировал первые страницы выдачи поисковой системы Google по запросам вида «к <году>», «в течение <года>», «в <году>» и т.д., где год менялся от 2012 до 2101. Результаты – заголовки статей – собраны в единую временную линию, из которой можно судить об ожиданиях человечества (или, по крайней мере, англоязычной его части) относительного грядущего.
  
## Поисковая система  
http://www.bing.com
  
## Структура запросов и временной горизонт  
"Экспорт газа из России до ..."
"Экспорт газа из России в ..."
"Экспорт газа из России после ..."
Год меняется от 2010 до 2019
  
## Файлы    
 1. ```Make_Timeline.R``` содержит скрипт R для сбора данных.  
 2. ```Timeline.csv``` содержит таблицу с собранными данными. Столбцы таблицы:  
  * **Year** – год, по которому сделан запрос.  
  * **Header** - заголовок статьи.  
  * **Source** - источник новости (адрес информационного источника, который виден на странице выдачи поисковика).  
  * **URL** - полная ссылка на источник.  

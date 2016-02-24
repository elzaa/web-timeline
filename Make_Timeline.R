# Упражнение 1 -----------------------------------------------------------------
# Экспорт газа из России (до, в, после)
# Вариант #11 (http://www.bing.com) ===========================================

# Загрузка пакетов
install.packages('RCurl')
install.packages('XML')
library('RCurl')
library('XML') 
# объявляем переменные 
years <- vector(mode = "numeric", length = 0)         # годы
headers <- vector(mode = "character", length = 0)     # заголовки
sources <- vector(mode = "character", length = 0)     # источники на странице
URLs <- vector(mode = "character", length = 0)        # полные источники
n=0
# Обрабатываем каждый из 3 запросов в цикле
for(i in seq(1,3)) {
# 3 варианта URL поисковой системы bing.com 
 if (i==1){
   fileURL = "http://www.bing.com/search?q=%D0%AD%D0%BA%D1%81%D0%BF%D0%BE%D1%80%D1%82+%D0%B3%D0%B0%D0%B7%D0%B0+%D0%B8%D0%B7+%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B8+%D0%B4%D0%BE&go=%D0%9E%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D1%8C&qs=n&form=QBRE&pq=%D1%8D%D0%BA%D1%81%D0%BF%D0%BE%D1%80%D1%82+%D0%B3%D0%B0%D0%B7%D0%B0+%D0%B8%D0%B7+%D1%80%D0%BE%D1%81%D1%81%D0%B8%D0%B8+%D0%B4%D0%BE&sc=0-22&sp=-1&sk=&cvid=FB89056DF91D4D53926D20B457CEC3EB"
}
 if (i==2){
   fileURL = "http://www.bing.com/search?q=%D0%AD%D0%BA%D1%81%D0%BF%D0%BE%D1%80%D1%82+%D0%B3%D0%B0%D0%B7%D0%B0+%D0%B8%D0%B7+%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B8+%D0%B2&go=%D0%9E%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D1%8C&qs=n&form=QBRE&pq=%D1%8D%D0%BA%D1%81%D0%BF%D0%BE%D1%80%D1%82+%D0%B3%D0%B0%D0%B7%D0%B0+%D0%B8%D0%B7+%D1%80%D0%BE%D1%81%D1%81%D0%B8%D0%B8+%D0%B2&sc=0-0&sp=-1&sk=&cvid=56908BFD6B7543C8BAFDDDC57E6E9642"
}
 if (i==3){
   fileURL = "http://www.bing.com/search?q=%D0%AD%D0%BA%D1%81%D0%BF%D0%BE%D1%80%D1%82+%D0%B3%D0%B0%D0%B7%D0%B0+%D0%B8%D0%B7+%D0%A0%D0%BE%D1%81%D1%81%D0%B8%D0%B8+%D0%BF%D0%BE%D1%81%D0%BB%D0%B5&go=%D0%9E%D1%82%D0%BF%D1%80%D0%B0%D0%B2%D0%B8%D1%82%D1%8C&qs=n&form=QBRE&pq=%D1%8D%D0%BA%D1%81%D0%BF%D0%BE%D1%80%D1%82+%D0%B3%D0%B0%D0%B7%D0%B0+%D0%B8%D0%B7+%D1%80%D0%BE%D1%81%D1%81%D0%B8%D0%B8+%D0%BF%D0%BE%D1%81%D0%BB%D0%B5&sc=0-0&sp=-1&sk=&cvid=DF9DD489B7584E0CAFE5291C424CBA19"
}

# В цикле перебираем года
for(j in 2010:2019){
  # Загружаем текст html-страницы
  html <- getURL(paste(c(fileURL, as.character(j)), collapse ='+'))
  # Разбираем как html
  doc <- htmlTreeParse(html, useInternalNodes = T,encoding = "UTF-8")
  # Получаем корневой элемент
  rootNode <- xmlRoot(doc)
  # Выбираем все заголовки результатов запрос
  headers <- c (headers, xpathSApply(rootNode, '//h2/a', xmlValue))
  m <- length(headers) - n
  # Создаём столбец лет
  years <- c (years, rep(j,m))
  n <- length(headers)
  # Получаем полные ссылки на источники
  URLs <- c (URLs, xpathSApply(rootNode, '//h2/a', xmlGetAttr,'href'))
  # Получаем указанные на странице источники
  sources <- c (sources, xpathSApply(rootNode, '//div[@class="b_attribution"]', xmlValue))  
}
}
# Преобразуем данные во фрейм
data <- data.frame(Year = years, Header = headers, Source = sources, URL = URLs)
View(data)
# Записываем фрейм в файл Timeline.csv
write.csv(data, file = './Timeline.csv', append = T, row.names = F)

print('Запись файла Timeline.csv завершена')

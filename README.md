
Тестовое задание в компанию VKPhoto

Приложение для просмотра фотографий из альбомов VK


Архитектура и библотеки, технологии:
- UIKit
- MVVM + Coordinator
- VK OAuth 2.0
- Async/await
- Code layout
- Target iOS 15.0, Target Device- iPhone
- Кэширование изображений
- Поддержка Dark/Light mode 
- Keychain
- GitFlow
- Eng/Rus localization 
- Custom reusable views 

SPM:
- SnapKit


Задачи:

Развернуть проект -15 мин
1. 	- добавить README
	- удалить Storyboard  
	- добавить gitIgnore	
	- iOS Deployment target - 15.0
	- Target Device- iPhone
2. Настроить Git, перейти на develop
3. Установить SnapKit  


Общие

1.  Написать AuthService  - 3 часа
	- Изучить документацию VK Api на предмет процесса авторизации
	Возможности сервиса:
	- запросить ключ доступа через Implicit Flow
	- вытащить данные пользователя ( accessToken, userID, tokenExpirationDate) 
	- проверить статус авторизации
	- сохранить данные пользователя в Keychain

Логика Coordinator в зависимости от результата авторизации
- Если пользователь не был залогинен ранее - открыть LoginScreenVC пройти авторизацию. Для этого сделать запрос в Keychain получить данные пользователя
 	- Проверить валидность токена: если токен действующий переходим к GalleryScreenVC, если истек переходим в LoginScreenVC для повторной 	авторизации 
	- Если пользователь залогинился и получил токен - сохранить токен и дату его истечения перейти к GalleryScreenVC


2.  Написать Coordinator для навигации  - 3 часа
Перед появлением какой-либо вью на экране при запуске приложения должна пройти проверка авторизации c помощью AuthService :
Методы для представления LoginScreenVC, WebViewVC, GalleryScreenVC, PhotoScreenVC

3. Написать PersistenceManager на основе  Keychain для сохранения данных пользователя 2 часа 


4. Написать NetworkingManager и Models - 2 часа
	Предусмотреть следующие методы
	- фетчинг модели  PhotoResponse с сервера
 	- скачивание фотографий по ссылке 
		
	Модели:
	User 
	- user_id 
	- access_token
	- expiringDate

	PhotoResponse  согласно документации API
	Photo для сохранения даты и URL

	Энам с эндпоитами ссылок 
	Энам с  методами API
	
	Обработка ошибок
	- Энам с кодами ошибок от URLResponse
	
	Энам  ErrorMessage с понятными пользователю сообщениями об ошибках 	

UI


1. Создать reusable UI Components  1 часа
- TitleLabel
- Button с ENG/RUS слокализацией
- Сделать PhotoCell с плейсхолдером

2. Создать AlertController для представления пользователю сообщений об ошибках - 20 мин
AlertController должен пушить себя на экран, принимать и отображать ошибку  на основе ErrorMessage
Сделать extension для ViewController, чтобы доступ к AlertController был у каждого контроллера


3. LoginScreenVC - 2 часа
Зависимости - ViewModel, Coordinator,
- Логика работы:
При нажатии на кнопку происходит переход на  WebViewVC
 	
- Добавить на экран кнопку авторизацию
	- Кнопка должна иметь ENG/RUS локализацию
- Добавить Title «Mobile Up Gallery» 
- WebView в виде Modal screen c completion с результатом авторизации 
	
-

4. WebViewVC - 1час 
Зависимости - Coordinator, AuthService
Перед закрытием вью должна появится Alert об отмене авторизации 
При перенаправление с успешной авторизации распарсить URL и получить Токен авторизации 


5. GalleryScreenVC - 4 часа
Зависимости - ViewModel, Coordinator
	1. Сделать галерею изображений расположенных в два столбца 
	- UICollectionView 
	- Размер ячейки - 186x186p
	- Кол-во столбцов - 2
	- Вертикальный скроллинг 
 
	2. Добавить кнопку выхода из учетной записи в NavigationItem	- После выхода возвращаемся в LoginScreenVC
	- Кнопка должна иметь ENG/RUS локализацию
	3. Добавить переход на PhotoScreenVC при нажатии на ячейку

6. PhotoScreenVC - 4 часа 
Зависимости - ViewModel, Coordinator
- Добавить фотографию в центре экрана

	- Добавить кнопку Share в NavigationBar
	- при нажатии на кнопку появляется Share меню
	- в Share меню должна быть функция сохранения фотографии на устройство
	- после сохранения появляется Alert с сообщением о статусе сохранения. 




Дополнительно:
- Добавить горизонтальную ленту под фотографией  - 2 часа
- Добавить Pinch to Zoom Gesture на экране показа изображения -2 часа

Сделать локализацию для компонентов - 3 часа 
- Кнопка входа
	- «Вход через VK»
	- «Login via VK»
- Алерты с ошибками
- Уведомление об успешном сохранении 

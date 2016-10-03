## Task

Необходимо создать приложение со следующим функционалом:
1. При запуске показывается форма регистрации с полями ввода email и password. Также присутствует кнопка login. При вводе данных необходимо проверить их валидность (для email обязательно ­ 3 символа до @, сам символ @, 3 символа после @, точка, 2 символа после точки; для password ­ не менее 5­ти символов) и в зависимости от результата блокируем (неактивное состояние ­ 50% прозрачности) или разрешаем нажатие на кнопку login.
2. После нажатия на кнопку login в папке documents приложения создается файл (формат на Ваше усмотрение) с логином и паролем.
3. Происходит переход на экран с информацией о пользователе, на котором размещены нередактируемые лейбы:
- надпись “Email:”, email пользователя;- надпись “Password:”, password пользователя; ­ надпись “First name:”, имя пользователя;- надпись “Last name:”, фамилия пользователя;Также присутствует кнопка “Edit”. По нажатию на нее активируются поля для редактирования всех данных пользователя, а вместо кнопки “Edit” должны появится кнопки “Save” и “Cancel”.При нажатии на “Cancel” экран возвращается в исходное состояние до нажатия кнопки “Edit”, данные пользователя остаются старыми.При нажатии на кнопку “Save” происходит сохранение данных в файл и экран возвращается в исходное состояние до нажатие кнопки “Edit”.
4. При следующем запуске, если присутствует файл с валидными email и password, сразу показывать экран с данными пользователя.Требования к реализации:
- использовать ЯП Swift.
- работа с файловой системой должна происходить только в бэкграунде.
- UI должен быть сделан с использованием xib или storyboard. Обязательно с autolayout.   
­Если перейти в папку documents и вручную заменить файл с такой же структурой и именем, но другими данными, приложение должно использовать его при следующем старте/выходе с бэкграунда.

## Interface

<img src="https://raw.githubusercontent.com/KirkFawkes/RegisterTestApp/master/Documentation/TTT.png " alt="Preview" width="600" />
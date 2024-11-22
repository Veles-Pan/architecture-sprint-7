## Требования к безопасности

-   Шифрование данных
    Все данные, передаваемые между компаниями, должны быть в зашифрованном виде, так как информация чувствительная и содержит персональные данные

-   Изоляция данные и система доступов
    Данные одной компании не должны быть доступны другой компании

-   Контроль за доступами
    Нужно постоянно актуализировать роли и людей, которые имеют доступ к интерграции, тчобы своевременно изменять/удалять права

-   Защита информации и токенов
    Все токены, контракты и другие средтва для доступа к информации должны быть хорошо защищены (не хранятся в открытом виде, в коде, в файлике google docs и тд.)

-   Защита от угроз и уязвимостей
    Как партнёр на своей стороне, так и наша компания должны обеспечить защиту от распространённых угроз

-   Аудит безопасности
    Система должна предоставлять возможности проведения аудита безопасности раз в какое-то время

## Протоколы аутентификации и авторизации

-   Ролевая модель доступа
    У каждой роли свои возможности и доступ только к нем данным, которые нужны этой роли

-   Аутентификация через OpenID Connect
    Простой и удобный способ приложениям безопасно получать ограниченный доступ к ресурсам, передавая в JWT-токенах только нужные данные

-   Реализация MFA
    Обязательно ввести MFA, так как интеграция содержит персональные данные пользователей компании и нужно усилить защиту этих данных

-   Аудиты безопасности и информаирование сотрудников

## Взаимодействие между системами предприятия и внешней платформой

-   Взаимодействие будет через REST API с использованием JWT-токонев для авторизации и шифрованием данных

-   В компании существуют отдельные сервисы интеграций для разных партнёров: smart-home и communal. Это позволит изолировать их друг от друга и обеспечить лучшую безопасность и мониторинг

-   Логирование и мониторинг всх интеграций

-   Версионирование API. Партнёр должен поддерживать обратную совместимость со старым АПИ при любых изменениях

-   Технические ограничения. Нужно договорить о лимитах RPA, чтобы не перегружать сервисы, определить SLA, общие контракты

-   Dev-версия АПИ. В идеальном мире партнёр должен предоставлять АПИ для тестовой среды, чтобы можно было всё разрабатывать и тестировать не на проде
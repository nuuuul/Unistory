ERC20

Реализовать ERC20 токен

    1. Необходимо использовать библиотеку OpenZeppelin

    2. При деплое контракта должен происходить mint 100k токенов на все переданные в конструктор адреса (должен быть передан массив из нескольких адресов)

    3. Реализовать функцию *mint()*

        1. Принимает на вход в качестве параметров

            1. Адрес на которые необходимо заминтить токены

            2. Количество токенов, которые должны быть заминчены

        2. Суммарно количество всех токенов (total supply) не должно превышать лимит, указанный при деплое контракта

        3. Функция может вызвана только владельцем контракта

    4. Total supply токенов - 1000k

    5. Написать юнит-тесты на ВСЕ функции, которые реализуются в созданном смарт-контракте

    6. Необходимо задеплоить смарт-контракт токена в тестнет Ethereum - **Sepolia**

        1. RPC URL взять из Alchemy

        2. Тестнет ETH для Sepolia можно найти через запрос “sepolia faucet”

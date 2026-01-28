# autobridge

Демо-приложение для компании по подбору и привозу авто из Южной Кореи.

## Архитектура (Clean Architecture)

```
lib/
  app/                # инициализация, DI, приложение
  core/               # базовые вещи (инициализация Firebase)
  data/               # реализации репозиториев и модели
  domain/             # сущности и контракты репозиториев
  presentation/       # UI-слой (страницы и виджеты)
  services/           # сервисные утилиты (Hive box names)
```

**Поток данных:** UI → Repository (domain) → Data (Firestore/Hive) → Domain entities.

## Firebase: подключение

1. Создайте Firebase проект.
2. Подключите нужные сервисы: **Auth**, **Firestore**, **Storage** (по необходимости).
3. Выполните:

```bash
flutter pub add firebase_core firebase_auth cloud_firestore
dart pub global activate flutterfire_cli
flutterfire configure
```

4. После `flutterfire configure` появится `firebase_options.dart`.  
   Обновите `lib/core/firebase/firebase_initializer.dart`, если нужно.

## Минимальные коллекции Firestore

**cars**
```
brand: string
model: string
year: number
mileage: number
priceUsd: number
priceKgs: number
imageUrl: string
status: "inStock" | "customOrder"
updatedAt: timestamp
```

**users**
```
email: string
role: "admin" | "user"
updatedAt: timestamp
```

**requests**
```
fullName: string
phone: string
comment: string
budget: string
preferredBrand: string
preferredModel: string
createdAt: timestamp
```

## Hive (локальное хранение)

Используется для:
- избранных автомобилей;
- настроек пользователя (валюта и язык).

## Экранная структура

- **Главная**: список авто + поиск + кнопка «Связаться».
- **Избранное**: список избранных авто (Hive).
- **Профиль**: настройки + вход/выход + админка для редактирования авто.

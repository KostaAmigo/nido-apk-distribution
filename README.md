# NIDO — Android Beta

> 🏠 **NIDO** — приложение для поиска недвижимости (Expo React Native). Постоянная страница загрузки Android-беты.

<p align="center">
  <a href="https://github.com/KostaAmigo/nido-apk-distribution/releases/download/beta/NIDO-arm64-preview.apk"
     style="display:inline-block;padding:14px 28px;background:#2ea44f;color:#ffffff;font-size:18px;font-weight:700;border-radius:8px;text-decoration:none">
     ⬇️ Скачать NIDO для Android
  </a>
</p>

Прямая ссылка (без авторизации GitHub): [`https://github.com/KostaAmigo/nido-apk-distribution/releases/download/beta/NIDO-arm64-preview.apk`](https://github.com/KostaAmigo/nido-apk-distribution/releases/download/beta/NIDO-arm64-preview.apk)

<!-- beta-meta:start -->
| Параметр | Значение |
|---|---|
| **Версия** | 0.1.0 |
| **Сборка (commit)** | `a39822d` |
| **SHA-256** | `15e33fd4b5034c5d8dc89565cfbc9182e324ba0f5743273bf95ccca07dc4aae9` |
| **Опубликовано** | 2026-10-16 |
<!-- beta-meta:end -->

## Установка

1. Нажмите кнопку «Скачать NIDO для Android» выше.
2. Откройте скачанный `.apk` на устройстве Android.
3. Разрешите установку из неизвестных источников (если появится запрос).
4. APK подписан ключом NIDO (EAS keystore), поэтому он **устанавливается поверх предыдущей версии без потери данных**.

## Что такое канал `beta`

- Ссылка `.../releases/download/beta/NIDO-arm64-preview.apk` — **постоянная**.
- Она всегда указывает на **последнюю проверенную (QA) сборку**.
- Экспериментальные и непроверенные сборки публикуются под тегом своего commit и **не попадают** в канал `beta` автоматически.
- Продвижение в `beta` выполняется только скриптом `update-beta.sh` после успешного QA.

## Остальные сборки

Все релизы (включая экспериментальные) доступны на странице [Releases](https://github.com/KostaAmigo/nido-apk-distribution/releases).

---

Этот репозиторий содержит **только релизные артефакты** (APK). Исходный код, секреты и сервисные данные NIDO здесь отсутствуют.

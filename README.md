# DevNorte — Prototipo Astro v0.1

Comunidad abierta para programadores del norte de Chile y del mundo.

## Iniciar localmente

Requisitos: Node.js 20.19+ o 22.12+ y npm.

```bash
npm install
npm run dev
```

Abrir `http://localhost:4321`.

## Build y despliegue

```bash
npm run build
npm run preview
```

Subir el repositorio a GitHub y conectarlo a Vercel. Framework: Astro; build `npm run build`; output `dist`. Este prototipo es 100% estático y no necesita adaptador ni variables de entorno.

## Pantallas

- `/` — feed + filtro + búsqueda
- `/proyectos` — proyectos
- `/preguntas` — preguntas
- `/comunidad` — presentación y perfiles de ejemplo
- `/nuevo` — formulario de publicación
- `/publicacion/?id=demo-1` — detalle y comentarios
- `/perfil` — perfil ficticio
- `/reglas` — reglas de convivencia

## Límites conscientes del prototipo

- Publicaciones, votos y comentarios se almacenan con `localStorage`: **solo existen en el navegador donde se crean**.
- No hay base de datos, API, usuarios reales, login, controles de abuso ni moderación de servidor.
- Los perfiles y publicaciones iniciales son ficticios.
- No usar con información sensible ni presentarlo como una comunidad multiusuario operativa.
- Antes de abrir un servicio real: autenticación, backend, PostgreSQL, rate limits, controles de acceso, sanitización de contenido, denuncias, moderación y políticas de privacidad.

## Stack

Astro, CSS y JavaScript vanilla, sin React ni Tailwind ni dependencias de UI. Estructura pequeña para poder editarla fácilmente. Tipografía de Google Fonts con fallback local.

## Propuesta de backend (próxima etapa)

Tablas principales: `users`, `posts`, `comments`, `votes`, `categories`, `reports`. Puntos de entrada: autenticación OAuth GitHub, CRUD de posts, comentarios, búsqueda, votos y panel de moderación.

## Autoría

Concepto DevNorte. Prototipo inicial para validar UI/UX.

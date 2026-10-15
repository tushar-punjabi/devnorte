# DevNorte — Product Requirements Document v1.0

**Estado:** Borrador para validación | **Fecha:** 14 octubre 2026 | **Producto:** Comunidad de desarrolladores

## 1. Visión

Una comunidad abierta nacida en el norte de Chile para compartir proyectos, resolver dudas, encontrar colaboradores y aprender programación, con alcance progresivo hacia Chile, LATAM y el mundo.

## 2. Problema

Los desarrolladores y aprendices encuentran información dispersa entre redes sociales, foros y chats. Necesitan un lugar amigable, en español por defecto, para mostrar trabajo, recibir feedback útil y conectar con gente cercana a sus intereses.

## 3. Audiencia

- Principales: autodidactas, estudiantes, desarrolladores junior, creadores indie, ingenieros de software del Norte Grande.
- Secundarios: mentores, diseñadores, contribuyentes open source, comunidades tecnológicas de Chile y LATAM.
- Idioma inicial: español; internacionalización posterior.

## 4. Jobs to be done

1. Cuando termino un proyecto, quiero publicarlo y recibir feedback.
2. Cuando me bloqueo, quiero preguntar sin sentirme juzgado.
3. Cuando necesito colaboradores, quiero encontrar personas interesadas.
4. Cuando tengo experiencia, quiero ayudar y descubrir buenas ideas.

## 5. Alcance del MVP funcional

| ID | Función | Prioridad | Aceptación |
|---|---|---|---|
| DN-01 | Feed público | P0 | Se pueden ver entradas ordenadas por fecha y navegar al detalle. |
| DN-02 | Publicar | P0 | Cuenta autenticada puede crear título, cuerpo, categoría y enlace opcional. |
| DN-03 | Comentar | P0 | Cuenta autenticada puede comentar en publicaciones visibles. |
| DN-04 | Explorar proyectos | P0 | Página de proyectos filtrada por categoría. |
| DN-05 | Buscar | P0 | Búsqueda por título y contenido. |
| DN-06 | Perfil | P1 | Muestra alias, bio, enlaces y contribuciones públicas. |
| DN-07 | Login GitHub/email | P1 | Sesiones seguras; protección de rutas de escritura. |
| DN-08 | Votos y reportes | P1 | Una persona/un voto por publicación y reportes moderables. |
| DN-09 | Notificaciones | P2 | Avisos de respuestas y menciones. |
| DN-10 | Grupos/eventos | P2 | Espacios regionales y calendarios comunitarios. |

**Nota:** Prioridades P0 describen el MVP multiusuario objetivo, no significan que el prototipo estático ya tenga persistencia compartida.

## 6. Reglas de negocio

- Lectura pública sin cuenta.
- Escritura, votos y reportes requieren autenticación en producción.
- Alias público; correo privado.
- No permitir código HTML arbitrario ni scripts en publicaciones.
- Un voto por usuario por publicación; permitir deshacer.
- Reportes privados, revisados por moderación; no revelar denunciante.
- Registro de eventos de moderación para auditoría.
- Política de eliminación y retención de datos antes del lanzamiento real.

## 7. Estructura

`/`, `/proyectos`, `/preguntas`, `/comunidad`, `/nuevo`, `/publicacion/:id` (en prototipo `/publicacion/?id=...`), `/perfil/:usuario` (demo `/perfil`), `/reglas`.

## 8. Arquitectura propuesta

Frontend Astro + CSS; API Astro Actions o backend dedicado; PostgreSQL; login GitHub OAuth; hosting Vercel con adaptador para rutas server-side. El prototipo inicial usa Astro estático + `localStorage` y no tiene API/DB.

Entidades: User, Post, Category, Comment, Vote, Report, ModerationAction.

## 9. Requisitos no funcionales

- Mobile-first, accesibilidad de teclado, navegación semántica.
- HTTPS, control de acceso en servidor, limitación de tasa y antifraude antes de beta pública.
- Minimización de datos personales; sin geolocalización precisa obligatoria.
- Registros de errores sin secretos ni datos innecesarios.
- Protección contra spam, phishing, doxxing y publicación de secretos.
- Posibilidad de exportar y eliminar datos según las obligaciones legales aplicables.

## 10. Fuera de alcance v1

Chat 1:1, algoritmo de recomendación, publicidad, marketplace de empleo, vídeo nativo, pagos, gamificación avanzada y aplicaciones móviles nativas.

## 11. Métricas de validación (no resultados)

Primeros 30 días: 30 miembros invitados, 20 posts, al menos 10 autores o comentaristas activos. Métrica clave: porcentaje de publicaciones nuevas que reciben una respuesta útil en 72 h. Registrar medición solo con consentimiento y criterios de privacidad adecuados.

## 12. Riesgos

- Efecto de comunidad vacía: sembrar conversaciones y moderación activa.
- Spam y abuso: límites, reportes, revisión y normas.
- Alcance excesivo: no construir un Reddit completo antes de validar uso.
- Privacidad: definir políticas y bases legales aplicables para datos de usuarios en Chile y, eventualmente, otras jurisdicciones.

## 13. Plan de entrega

1. Prototipo estático navegable.
2. Pruebas de usabilidad con 5-10 personas.
3. Autenticación, base de datos y API.
4. Moderación y beta privada.
5. Lanzamiento comunitario por invitación y mejora basada en uso real.

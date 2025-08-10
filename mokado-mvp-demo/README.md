
# Mokado — Web MVP

A minimal web-based MVP for a digital coffee loyalty app using Supabase for auth and storage.

## Quick start

1. Create a Supabase project. Copy your **Project URL** and **anon** key into `.env`:
   ```bash
   cp .env.example .env
   # then fill in VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY
   ```
2. In Supabase SQL editor, run the SQL in `supabase/schema.sql`.
3. In **Authentication → Providers**, ensure **Email** is enabled. (Magic links recommended.)
4. In **Authentication → Policies**, confirm RLS is **enabled** (the SQL will do this).
5. Install deps & run:
   ```bash
   npm install
   npm run dev
   ```

### QR flow (MVP)
- Each café prints a **static QR** (from `/owner/qr`) that encodes a URL to `/scan?cafe=<id>`.
- Customer scans the QR after paying. On the page, the barista types a **4‑digit PIN** to validate.
- One point per coffee. Redeem a free coffee when reaching the café's threshold (default: 10).

### Abuse prevention (simple)
- Server-side rate limit: max 1 stamp per user per café per 3 minutes.
- PIN is stored as a bcrypt hash in the DB.
- Owners see analytics for their cafés.



## Deploy to Vercel (Preview URL in minutes)

1. Push this project to a **GitHub** repo.
2. Go to **Vercel → New Project → Import** your repo.
3. Keep defaults (Framework: *Vite*). The included `vercel.json` already sets:
   - `build` = `npm run build`
   - output directory = `dist`
   - SPA routing rewrite → `index.html`
4. Add **Environment Variables** in Vercel:
   - `VITE_SUPABASE_URL = <your_supabase_url>`
   - `VITE_SUPABASE_ANON_KEY = <your_supabase_anon_key>`
5. Click **Deploy**. Vercel will give you a live preview URL like `https://mokado.vercel.app`.
6. Optional: set a custom domain in Vercel → **Domains**.


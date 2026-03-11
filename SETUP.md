# AI Astrologer - Setup Instructions

## Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Configure Environment Variables
Create a `.env.local` file in the root directory with:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_key
OPENAI_API_KEY=your_openai_key
DAILY_API_KEY=your_daily_api_key
NEXT_PUBLIC_DAILY_DOMAIN=your_daily_domain
NEXT_PUBLIC_SOCKET_URL=http://localhost:3000
```

### 3. Run Development Server

**Default port (3000):**
```bash
npm run dev
```

**Custom port (8080):**
```bash
npm run dev:8080
```

Then open:
- http://localhost:3000 (default)
- http://localhost:8080 (if using custom port)

### 4. Access the Application

The app will automatically redirect to `/en` (English) by default. You can access:
- Home: http://localhost:3000/en
- Chat: http://localhost:3000/en/chat
- Dashboard: http://localhost:3000/en/dashboard
- And more...

## Important Notes

### Port Configuration
- Next.js runs on port **3000** by default
- If you see `ERR_CONNECTION_REFUSED` on port 8080, either:
  1. Use port 3000: `npm run dev`
  2. Or use the custom script: `npm run dev:8080`

### Routing Structure
The application uses `next-intl` for internationalization:
- All pages are under `app/[locale]/` directory
- Root path `/` redirects to `/en`
- Supported locales: en, hi, ta, te, bn, gu, mr

### Database Setup
1. Create a Supabase project
2. Run the SQL schema from `lib/supabase-schema.sql`
3. Update `.env.local` with your Supabase credentials

### API Keys Required
- **OpenAI**: For AI chatbot and predictions
- **Daily.co**: For video consultations (optional for development)
- **Supabase**: For database and authentication

## Troubleshooting

### Connection Refused Error
- Ensure the dev server is running: `npm run dev`
- Check if port 3000 is available
- Try accessing http://localhost:3000 instead of 8080

### Build Errors
- Clear `.next` folder: `rm -rf .next`
- Reinstall dependencies: `rm -rf node_modules && npm install`
- Check Node.js version (requires 18+)

### i18n Issues
- Ensure all pages are under `app/[locale]/` directory
- Check that `middleware.ts` is in the root directory
- Verify `i18n/config.ts` exists

## Features Implemented

✅ Multi-language support (7 languages)
✅ AI Chatbot with OpenAI
✅ Kundli Matching
✅ Real-time chat infrastructure
✅ Video consultation setup
✅ User Dashboard
✅ Birth Chart (basic)
✅ Tarot Reading
✅ Horoscope
✅ Pricing page
✅ Navigation with language switcher

## Next Steps

1. Set up Supabase database
2. Configure API keys
3. Set up Socket.io server (for real-time chat)
4. Configure Daily.co (for video calls)
5. Complete remaining features (notifications, blog, predictions)

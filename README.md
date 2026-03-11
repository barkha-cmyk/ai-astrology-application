# AI Astrologer

A modern astrology consultation platform similar to AstroTalk, built with Next.js, TypeScript, and Tailwind CSS.

## Features

- **Expert Profiles**: Browse and connect with verified advisors
- **Live Consultations**: Chat, voice call, or video call with experts
- **Daily Horoscope**: Get personalized daily horoscopes for all zodiac signs
- **Birth Chart Analysis**: Generate detailed birth charts based on birth details
- **Tarot Reading**: Various tarot card reading options
- **Payment Integration**: Secure payment processing for chargeable features
- **Responsive Design**: Works seamlessly on desktop, tablet, and mobile devices

## Getting Started

### 🚀 Quick Start (Easiest Method)

**For Windows Users:**
- **Double-click `start.bat`** to start on port 3000
- **Double-click `start-8080.bat`** to start on port 8080
- The script will automatically install dependencies and start the server!

**For All Users:**
```bash
npm install    # First time only
npm run dev    # Start on port 3000
# OR
npm run dev:8080  # Start on port 8080
```

### Prerequisites

- Node.js 18+ installed
- npm or yarn package manager

### Manual Installation

1. Install dependencies:
```bash
npm install
```

2. Run the development server:
```bash
npm run dev        # Port 3000 (default)
npm run dev:8080   # Port 8080 (alternative)
```

3. Open [http://localhost:3000](http://localhost:3000) or [http://localhost:8080](http://localhost:8080) in your browser

**Note:** The application will automatically redirect to `/en` (English version). Use the language switcher to change languages.

## Project Structure

```
├── app/                    # Next.js app directory
│   ├── horoscope/         # Daily horoscope page
│   ├── birth-chart/       # Birth chart generation page
│   ├── tarot/             # Tarot reading page
│   ├── pricing/           # Pricing plans page
│   └── page.tsx           # Homepage
├── components/            # React components
│   ├── Navbar.tsx        # Navigation bar
│   └── Footer.tsx        # Footer component
└── public/               # Static assets
```

## Technologies Used

- **Next.js 14**: React framework with App Router
- **TypeScript**: Type-safe JavaScript
- **Tailwind CSS**: Utility-first CSS framework
- **Lucide React**: Icon library
- **Framer Motion**: Animation library

## Payment Integration

The application includes payment forms for chargeable features. To integrate with a real payment gateway:

1. Set up Stripe or your preferred payment processor
2. Add API keys to environment variables
3. Implement payment API routes in `app/api/`

## Features Status

### ✅ Completed Features
- ✅ Multi-language support (7 languages: English, Hindi, Tamil, Telugu, Bengali, Gujarati, Marathi)
- ✅ AI-powered chatbot with OpenAI integration
- ✅ Kundli/Horoscope matching with compatibility analysis
- ✅ Real-time chat infrastructure (Socket.io)
- ✅ Video consultation setup (Daily.co)
- ✅ User dashboard with readings and appointments
- ✅ Interactive birth chart visualization (D3.js)
- ✅ AI-powered predictions (daily, weekly, monthly)
- ✅ Blog system with markdown support
- ✅ Notification system with push support
- ✅ Homepage with featured experts
- ✅ Daily horoscope for all zodiac signs
- ✅ Birth chart form with payment UI
- ✅ Tarot reading options
- ✅ Pricing page
- ✅ Responsive navigation with language switcher

### ⚠️ Requires Configuration
- Payment integration (UI ready, needs Stripe/Razorpay setup)
- Database features (requires Supabase setup)
- Real-time chat (requires Socket.io server setup)
- Video calls (requires Daily.co account)
- AI features (requires OpenAI API key)

## License

This project is created for demonstration purposes.


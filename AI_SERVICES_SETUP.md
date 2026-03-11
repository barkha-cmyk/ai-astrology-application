# AI Services Setup Guide

This guide will help you add and configure AI services for the AI Astrologer application.

## 🚀 Quick Setup (5 Minutes)

### Step 1: Get Your OpenAI API Key

1. **Sign up for OpenAI Account**
   - Go to https://platform.openai.com/signup
   - Create an account or sign in

2. **Get API Key**
   - Navigate to https://platform.openai.com/api-keys
   - Click "Create new secret key"
   - Copy the API key (you'll only see it once!)
   - **Important:** Keep this key secure and never share it publicly

3. **Add Credits (if needed)**
   - Go to https://platform.openai.com/account/billing
   - Add payment method and credits
   - Note: GPT-3.5-turbo is very affordable (~$0.002 per 1K tokens)

### Step 2: Create Environment File

1. **Create `.env.local` file** in the root directory of your project
   - Location: `C:\Users\WINDOWS 11\OneDrive\ai astro\.env.local`

2. **Add your API key** to the file:

```env
# OpenAI API Configuration (REQUIRED for AI features)
OPENAI_API_KEY=sk-your-actual-api-key-here

# Optional: Other services (can be added later)
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_key
DAILY_API_KEY=your_daily_api_key
NEXT_PUBLIC_DAILY_DOMAIN=your_daily_domain
NEXT_PUBLIC_SOCKET_URL=http://localhost:8080
```

**Example:**
```env
OPENAI_API_KEY=sk-proj-abc123xyz789...
```

### Step 3: Restart the Server

After adding the API key:

1. **Stop the current server** (Press `Ctrl+C` in the terminal)
2. **Restart the server:**
   ```bash
   npm run dev:8080
   ```
   Or double-click `start-8080.bat`

3. **Wait for compilation** (10-20 seconds)
4. **Refresh your browser** at http://localhost:8080

## ✅ Verify AI Services Are Working

### Test AI Chatbot
1. Go to http://localhost:8080/en/chat
2. Type a message like "Tell me about Aries"
3. You should get an AI-powered response

### Test Kundli AI Analysis
1. Go to http://localhost:8080/en/kundli-matching
2. Fill in birth details for two people
3. Click "Calculate Compatibility"
4. Click "Get AI-Powered Detailed Analysis"
5. You should get detailed AI insights

### Test AI Horoscope
1. Go to http://localhost:8080/en/predictions
2. Select a zodiac sign
3. Get AI-generated predictions

## 🎯 What AI Services Are Included?

### 1. **AI Chatbot** (`/chat`)
- Conversational astrology assistant
- Answers questions about astrology, zodiac signs, compatibility
- Remembers conversation context

### 2. **Kundli Matching AI** (`/kundli-matching`)
- Detailed analysis of compatibility scores
- Explains gun milan points
- Answers questions about kundli results
- Provides astrological insights

### 3. **Horoscope Predictions** (`/predictions`)
- Daily, weekly, monthly horoscopes
- Personalized predictions for each zodiac sign
- Includes love, career, health, and luck insights

### 4. **Birth Chart Analysis** (`/birth-chart`)
- AI-powered birth chart interpretation
- Planetary position analysis
- Personality trait insights
- Life predictions

## 💰 Cost Estimation

**OpenAI GPT-3.5-turbo Pricing:**
- Input: $0.50 per 1M tokens
- Output: $1.50 per 1M tokens
- Average chat message: ~100 tokens
- **Cost per 1000 chats: ~$0.20**

**Example Monthly Costs:**
- 1,000 chats/month: ~$0.20
- 10,000 chats/month: ~$2.00
- 100,000 chats/month: ~$20.00

**Very affordable!** Most small applications spend less than $10/month.

## 🔧 Advanced Configuration

### Change AI Model

Edit `lib/ai-service.ts`:

```typescript
// Current (affordable):
model: 'gpt-3.5-turbo'

// More powerful (expensive):
model: 'gpt-4'
model: 'gpt-4-turbo-preview'
```

### Adjust Response Length

```typescript
// Current:
max_tokens: 500

// Longer responses:
max_tokens: 1000
max_tokens: 2000
```

### Adjust Creativity

```typescript
// Current (balanced):
temperature: 0.7

// More creative:
temperature: 0.9

// More focused:
temperature: 0.5
```

## 🛠️ Troubleshooting

### Issue: "AI service is not configured"
**Solution:** 
- Check that `.env.local` exists in the root directory
- Verify `OPENAI_API_KEY` is set correctly
- Restart the server after adding the key

### Issue: "Failed to get AI response"
**Solutions:**
- Check your OpenAI account has credits
- Verify API key is correct (starts with `sk-`)
- Check internet connection
- Look at server console for error details

### Issue: "Rate limit exceeded"
**Solution:**
- You've exceeded OpenAI's rate limits
- Wait a few minutes and try again
- Consider upgrading your OpenAI plan

### Issue: "Invalid API key"
**Solution:**
- Verify the API key is correct
- Make sure there are no extra spaces
- Check the key hasn't been revoked on OpenAI dashboard

## 🔒 Security Best Practices

1. **Never commit `.env.local` to Git**
   - It's already in `.gitignore`
   - Never share your API key publicly

2. **Use Environment Variables**
   - Always use `.env.local` for local development
   - Use your hosting platform's environment variables for production

3. **Rotate Keys Regularly**
   - If a key is exposed, revoke it immediately
   - Generate a new key from OpenAI dashboard

4. **Monitor Usage**
   - Check OpenAI dashboard regularly
   - Set up usage alerts
   - Monitor costs

## 📚 Additional Resources

- **OpenAI Documentation:** https://platform.openai.com/docs
- **OpenAI Pricing:** https://openai.com/pricing
- **API Reference:** https://platform.openai.com/docs/api-reference
- **Best Practices:** https://platform.openai.com/docs/guides/production-best-practices

## 🎉 You're All Set!

Once you've added your OpenAI API key, all AI features will work automatically:
- ✅ AI Chatbot
- ✅ Kundli AI Analysis
- ✅ AI Horoscopes
- ✅ Birth Chart AI Insights

Enjoy your AI-powered astrology application!

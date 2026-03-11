@echo off
echo ========================================
echo   Setting up OpenRouter API Configuration
echo ========================================
echo.

echo Creating .env.local file...
(
echo OPENROUTER_API_KEY=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
echo OPENROUTER_MODEL=openai/gpt-5.2
) > .env.local

echo.
echo ✓ .env.local file created successfully!
echo.
echo Next steps:
echo 1. Restart your server (stop and start again)
echo 2. Test the chat feature at http://localhost:8080/chat
echo.
pause

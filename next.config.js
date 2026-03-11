const createNextIntlPlugin = require('next-intl/plugin')

const withNextIntl = createNextIntlPlugin('./i18n/request.ts')

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  images: {
    domains: ['images.unsplash.com'],
  },
  // Disable debugging in production
  productionBrowserSourceMaps: false,
  // Optimize for production
  swcMinify: true,
  webpack: (config, { isServer }) => {
    // Ensure formatjs modules are properly resolved
    if (!isServer) {
      config.resolve.fallback = {
        ...config.resolve.fallback,
        fs: false,
      }
    }
    return config
  },
}

module.exports = withNextIntl(nextConfig)


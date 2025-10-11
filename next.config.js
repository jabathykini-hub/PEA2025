/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  images: { unoptimized: true },
  reactStrictMode: true,
  basePath: '/PEA2025',
  assetPrefix: '/PEA2025/',
};
module.exports = nextConfig;

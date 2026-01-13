# 🌸 Perfume Palace - Luxury Perfume E-Commerce Store

A production-ready e-commerce platform built with Bagisto (Laravel) for selling premium perfumes online.

## ✨ Features

- 🛍️ **Full E-Commerce Functionality**
  - Product catalog with images
  - Shopping cart
  - Checkout process
  - Order management
  
- 💎 **Premium Product Showcase**
  - 71+ luxury perfume products
  - High-quality product images
  - Detailed descriptions
  - Price sorting and filtering

- 🎨 **Modern Interface**
  - Responsive design
  - Mobile-friendly
  - Fast loading times
  - Optimized images

- 🔐 **Secure & Reliable**
  - HTTPS encryption
  - Secure payment processing
  - Session management
  - Data protection

## 🚀 Quick Start

### Local Development

1. **Clone & Install**:
   ```bash
   git clone https://github.com/Feynman-0/PerfumePalace-Ecom.git
   cd PerfumePalace-Ecom
   composer install
   npm install
   ```

2. **Environment Setup**:
   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

3. **Database**:
   ```bash
   # Update .env with your database credentials
   php artisan migrate
   php artisan db:seed
   ```

4. **Run**:
   ```bash
   npm run build
   php artisan serve
   ```

Visit: http://localhost:8000

### Production Deployment

See [PRODUCTION.md](PRODUCTION.md) for complete deployment guide.

**Quick Deploy to Railway**:
1. Connect GitHub repository
2. Add MySQL database
3. Set environment variables
4. Deploy!

## 🎯 Project Structure

```
PerfumePalace-Ecom/
├── app/                  # Application logic
├── config/              # Configuration files
├── database/            # Migrations & seeders
├── packages/            # Bagisto packages
│   └── Webkul/         # Core e-commerce logic
├── public/             # Web root
│   └── storage/        # Public uploads
├── resources/          # Views & assets
├── routes/             # Application routes
├── storage/            # App storage
└── nixpacks.toml       # Railway deployment config
```

## 🔧 Tech Stack

- **Backend**: PHP 8.2, Laravel 11, Bagisto
- **Frontend**: Blade Templates, Tailwind CSS, Vue.js
- **Database**: MySQL 8
- **Deployment**: Railway.app
- **Assets**: Vite

## 📦 Key Dependencies

- `bagisto/bagisto` - E-commerce framework
- `laravel/framework` - PHP framework
- `intervention/image` - Image processing
- `mpdf/mpdf` - PDF generation

## 🌐 Live URLs

- **Storefront**: https://perfumepalace-ecom-production.up.railway.app
- **Admin Panel**: https://perfumepalace-ecom-production.up.railway.app/admin

## 👤 Admin Access

Default credentials (⚠️ **CHANGE IN PRODUCTION**):
- Email: `admin@example.com`
- Password: `admin123`

## 🎨 Customization

### Theme
Located in: `packages/Webkul/Shop/src/Resources/`

### Products
- Add/Edit via Admin Panel → Catalog → Products
- Images go to: `storage/app/public/product/`

### Configuration
- Admin Panel → Configuration
- Settings for store, locale, currency, etc.

## ⚡ Performance

- **OPcache** enabled for PHP optimization
- **Asset bundling** with Vite
- **Database indexing** via Bagisto
- **Image optimization** recommended < 500KB
- **CDN ready** (configure in admin)

## 🔒 Security

- ✅ Environment variables for secrets
- ✅ CSRF protection
- ✅ SQL injection prevention
- ✅ XSS protection
- ✅ Secure sessions
- ✅ HTTPS enforced in production

## 📝 Common Tasks

### Clear Caches
```bash
php artisan optimize:clear
```

### Optimize for Production
```bash
php artisan optimize
```

### Create Admin User
```bash
php artisan bagisto:admin:create
```

### Reindex Products
```bash
php artisan bagisto:indexer:reindex
```

## 🐛 Troubleshooting

See [PRODUCTION.md](PRODUCTION.md#-troubleshooting) for common issues and solutions.

## 📄 License

This project is built on Bagisto, which is MIT licensed.

## 🤝 Contributing

This is a private e-commerce store. For issues or improvements, please contact the repository owner.

## 📧 Contact

For support or inquiries about Perfume Palace, please use the contact form on the website.

---

**Made with ❤️ using Bagisto**

<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class SecurityHeaders
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next): Response
    {
        $response = $next($request);

        // Only apply security headers in production
        if (app()->environment('production')) {
            $response->headers->set('X-Frame-Options', 'SAMEORIGIN');
            $response->headers->set('X-Content-Type-Options', 'nosniff');
            $response->headers->set('X-XSS-Protection', '1; mode=block');
            $response->headers->set('Referrer-Policy', 'strict-origin-when-cross-origin');
            $response->headers->set('Permissions-Policy', 'geolocation=(), microphone=(), camera=()');
            
            // Strict Transport Security (HSTS) - only over HTTPS
            if ($request->secure()) {
                $response->headers->set('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
            }

            // Content Security Policy (adjust based on your needs)
            $response->headers->set('Content-Security-Policy', 
                "default-src 'self'; " .
                "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://cdn.jsdelivr.net https://www.googletagmanager.com; " .
                "style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; " .
                "img-src 'self' data: https: blob:; " .
                "font-src 'self' data: https://fonts.gstatic.com; " .
                "connect-src 'self'; " .
                "frame-ancestors 'self';"
            );
        }

        return $response;
    }
}

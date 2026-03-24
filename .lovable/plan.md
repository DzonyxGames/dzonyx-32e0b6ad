
# DZONYX – Horror Game Studio Website

## Overview
A dark, horror-themed website for Dzonyx game studio with glitch/flicker effects, featuring games showcase, news, donations, user suggestions, and a full admin panel.

## Design & Theme
- **Dark horror aesthetic**: Black (#000) background, dark grays, red glow accents
- **Effects**: CSS glitch animations, flicker effects, subtle screen noise overlay
- **Typography**: Bold, distressed-style headings; clean body text
- **Steam/Epic Games icons**: Custom store link buttons (like the uploaded reference image) that only appear when a link is provided

## Pages & Features

### 1. Home Page
- Hero section: "DZONYX" title with glitch effect + subtitle "We create horror experiences"
- Dark atmospheric background
- Featured Games section (thumbnails + titles + buttons)
- About section
- Suggestions panel (post ideas/feedback/complaints)

### 2. Auth System (Lovable Cloud)
- Sign Up: username (unique), email (unique), password
- Login: email + password
- Pre-seeded admin account: `dzonyx@dzonyx.com` / `Nikolapro1!`
- Admin has full permissions (manage games, news, suggestions, mute users)

### 3. Games Page
- Game cards with title, description, images, videos
- Store links: Steam and Epic Games icons (only shown when link is set by admin)
- Clicking icon opens the store link in new tab

### 4. News Page
- News posts with: video embed / image / text message
- Admin can create, edit, delete news
- Display as a feed with dates

### 5. Donation Page
- Bank account info: RS35170001089853000194
- Predefined amounts: 1€, 5€, 10€, 25€, 50€, 100€
- Custom amount input
- "All donations are final. No refunds." notice

### 6. Suggestions System
- Users post suggestions marked as Public or Private
- Public: visible to all; Private: only admin sees
- Users can delete their own suggestions
- Admin can delete any, mute users

### 7. Admin Panel
- Dashboard with overview
- Manage Games: add/edit/delete games, set free/paid, add Steam/Epic links, upload images/videos
- Manage News: create/edit/delete news posts (video/image/text)
- Manage Suggestions: view all (including private), delete any
- Manage Users: view users, mute/unmute, delete user content

## Database (Supabase)
- **profiles**: id, username, email, muted, avatar_url
- **user_roles**: id, user_id, role (admin/user)
- **games**: id, title, description, price, is_free, steam_link, epic_link, images, videos, is_public, created_at
- **news**: id, title, content, media_type, media_url, created_at
- **suggestions**: id, user_id, text, is_public, created_at
- RLS policies for all tables


Problem je dvostruk:

1. Aktivni preview i dalje učitava stari build koji sadrži OTP ekran.
2. Čak i u source kodu signup još nije skroz prebačen na tvoj traženi flow, jer i dalje traži username i prikazuje poruku za potvrdu emaila.

Šta ću ispraviti:

1. Ukloniti stari OTP UI iz onoga što se stvarno učitava
- `index.html` trenutno učitava stari bundle iz `assets/index-DAZuvah9.js`
- taj bundle i dalje sadrži `Email Verification`, `Verify Code` i poziv ka `/auth/v1/otp`
- prebaciću entry nazad na `src/main.tsx` da preview koristi aktuelni React kod

2. Očistiti auth ekran na čisti email + password
- u `src/pages/Auth.tsx` ukloniću sve što nije potrebno za tvoj flow
- signup forma će imati samo:
  - email
  - password
- login forma će imati samo:
  - email
  - password
- ukloniću `username` stanje, polje i validaciju
- promeniću tekstove da više nema nikakvog pominjanja koda ili potvrde

3. Pojednostaviti auth context
- u `src/contexts/AuthContext.tsx` promeniću `signUp` potpis da više ne traži `username`
- signup će slati samo email i password
- ukloniću `emailRedirectTo` jer više nema potrebe za verifikacionim link flow-om ako želiš potpuno bez potvrde

4. Uskladiti backend auth podešavanje sa tim zahtevom
- trenutno je jasno da backend još uvek traži OTP/confirmation u realnom toku
- zato ću isključiti obaveznu email potvrdu u auth podešavanju, tako da nalog radi odmah sa email + password
- ovo je jedini način da zaista nema ni koda ni potvrde, ne samo vizuelno nego i funkcionalno

5. Ostaviti profile/uloge da rade bez username unosa
- to neću rušiti jer admin deo koristi `profiles`
- postojeća backend funkcija već уме da sama napravi username iz email adrese ako korisnik ne unese username
- zato nije potrebna nova tabela ni velika migracija

6. Završno čišćenje
- ukloniću nekorišćeni OTP komponent (`src/components/ui/input-otp.tsx`) i preostale reference ako postoje
- proveriću da više nema:
  - `signInWithOtp`
  - `verifyOtp`
  - OTP tekstova
  - “check your email” poruka na auth stranici

Tehnički detalji
```text
Traženi flow:
Sign up: email + password -> account created -> user može odmah login
Login:   email + password -> ulaz bez koda

Glavni uzrok zabune:
preview trenutno ne koristi aktuelni source kod,
nego stari kompajlirani JS bundle koji još ima OTP flow
```

Fajlovi koje ću menjati:
- `index.html`
- `src/pages/Auth.tsx`
- `src/contexts/AuthContext.tsx`
- verovatno brisanje/uklanjanje reference na `src/components/ui/input-otp.tsx`

Šta će rezultat biti:
- nema koda
- nema verifikacije emailom
- samo email + password za signup
- samo email + password za login
- preview više neće prikazivati stari OTP ekran

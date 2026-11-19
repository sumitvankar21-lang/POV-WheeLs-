
<!DOCTYPE html>
<html lang="en" class="dark scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>POV Wheels | Sumit Vankar - Automotive Videography & Editing</title>
    
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,300..800;1,9..40,300..800&family=JetBrains+Mono:wght@400;500;600;700;800&family=Poppins:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <!-- FontAwesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            darkMode: 'class',
            theme: {
                extend: {
                    fontFamily: {
                        heading: ['Poppins', 'sans-serif'],
                        body: ['DM Sans', 'sans-serif'],
                        mono: ['JetBrains Mono', 'monospace'],
                    },
                    colors: {
                        obsidian: '#030303',
                        chrome: {
                            50: '#F8FAFC',
                            100: '#F1F5F9',
                            400: '#94A3B8',
                            600: '#475569',
                            800: '#1E293B',
                            900: '#0F172A',
                            accent: '#E2E8F0',
                            silver: '#C0C0C0',
                            platinum: '#E5E4E2'
                        }
                    },
                    boxShadow: {
                        'glass-edge': 'inset 0 1px 1px 0 rgba(255, 255, 255, 0.25), 0 20px 50px rgba(0, 0, 0, 0.6)',
                        'silver-glow': '0 0 25px rgba(226, 232, 240, 0.25)',
                    }
                }
            }
        }
    </script>
    
    <!-- QRCode.js Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

    <style>
        /* Core Reset & Fonts */
        * {
            box-sizing: border-box;
            -webkit-tap-highlight-color: transparent;
        }
        body {
            background-color: #000000;
            color: #f1f5f9;
            font-family: 'DM Sans', sans-serif;
            overflow-x: hidden;
        }
        h1, h2, h3, h4, h5, h6, .font-heading {
            font-family: 'Poppins', sans-serif;
        }
        .font-mono-num {
            font-family: 'JetBrains Mono', monospace;
        }

        /* -------------------------------------------------------------
           PRELOADER ANIMATION
        ------------------------------------------------------------- */
        #preloader {
            position: fixed;
            inset: 0;
            z-index: 9999;
            background: #030303;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            transition: transform 0.8s cubic-bezier(0.85, 0, 0.15, 1), opacity 0.8s ease;
        }
        
        #preloader.loaded {
            transform: translateY(-100%);
            opacity: 0;
            pointer-events: none;
        }

        @keyframes wheelSpin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .spin-wheel {
            animation: wheelSpin 4s linear infinite;
        }

        @keyframes silverShineSweep {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(200%); }
        }
        .silver-sweep {
            position: relative;
            overflow: hidden;
        }
        .silver-sweep::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            animation: silverShineSweep 2.5s ease-in-out infinite;
        }

        /* -------------------------------------------------------------
           SPATIAL LIQUID GLASS (iOS 26 GLASSMORPHISM)
        ------------------------------------------------------------- */
        .liquid-glass {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(28px) saturate(170%);
            -webkit-backdrop-filter: blur(28px) saturate(170%);
            border: 1px solid rgba(255, 255, 255, 0.09);
            box-shadow: 
                inset 0 1px 1px 0 rgba(255, 255, 255, 0.2),
                inset 0 -1px 1px 0 rgba(0, 0, 0, 0.4),
                0 20px 40px -15px rgba(0, 0, 0, 0.7);
            transition: border-color 0.4s ease, box-shadow 0.4s ease, transform 0.3s cubic-bezier(0.2, 0.8, 0.2, 1);
        }

        .liquid-glass:hover {
            border-color: rgba(255, 255, 255, 0.22);
            box-shadow: 
                inset 0 1px 2px 0 rgba(255, 255, 255, 0.35),
                0 25px 50px -12px rgba(0, 0, 0, 0.9),
                0 0 20px rgba(255, 255, 255, 0.08);
        }

        .glass-pill {
            background: rgba(18, 18, 22, 0.65);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border: 1px solid rgba(255, 255, 255, 0.12);
        }

        /* Staggered Entrance Keyframes */
        .reveal-item {
            opacity: 0;
            transform: translateY(30px);
            transition: opacity 0.8s cubic-bezier(0.16, 1, 0.3, 1), transform 0.8s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .reveal-item.active {
            opacity: 1;
            transform: translateY(0);
        }

        /* Liquid Wave Canvas Container */
        #bg-canvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            z-index: -2;
            pointer-events: none;
        }

        /* Seamless Car Background Overlay Layer */
        .car-bg-overlay {
            position: fixed;
            inset: 0;
            z-index: -1;
            pointer-events: none;
            overflow: hidden;
        }
        
        .car-mask-layer {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0.18;
            background-size: cover;
            background-position: center;
            mix-blend-mode: luminosity;
            filter: grayscale(80%) contrast(120%) brightness(80%);
            mask-image: radial-gradient(circle at center, rgba(0,0,0,1) 20%, rgba(0,0,0,0) 75%);
            -webkit-mask-image: radial-gradient(circle at center, rgba(0,0,0,1) 20%, rgba(0,0,0,0) 75%);
            transition: opacity 1s ease;
        }

        /* Custom Toast Notification */
        #toast {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%) translateY(100px);
            opacity: 0;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            z-index: 10000;
        }
        #toast.show {
            transform: translateX(-50%) translateY(0);
            opacity: 1;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #030303;
        }
        ::-webkit-scrollbar-thumb {
            background: #262626;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #404040;
        }
    </style>
</head>
<body class="relative text-slate-100 antialiased selection:bg-slate-200 selection:text-black">

    <!-- ===================================================================
         1. CINEMATIC OPENING PRELOADER CURTAIN
    ==================================================================== -->
    <div id="preloader">
        <div class="relative flex flex-col items-center justify-center space-y-6">
            <!-- Spinning Alloy Wheel Logo -->
            <div class="relative w-28 h-28 flex items-center justify-center">
                <div class="absolute inset-0 rounded-full border border-white/20 animate-ping opacity-25"></div>
                <svg class="w-24 h-24 spin-wheel text-slate-200 drop-shadow-[0_0_15px_rgba(255,255,255,0.4)]" viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="50" cy="50" r="46" stroke="currentColor" stroke-width="4" stroke-opacity="0.8"/>
                    <circle cx="50" cy="50" r="40" stroke="currentColor" stroke-width="1.5" stroke-dasharray="4 3"/>
                    <!-- 5-Spoke Alloy Rim Design -->
                    <g stroke="currentColor" stroke-width="4" stroke-linecap="round">
                        <line x1="50" y1="50" x2="50" y2="10" />
                        <line x1="50" y1="50" x2="88" y2="38" />
                        <line x1="50" y1="50" x2="73" y2="82" />
                        <line x1="50" y1="50" x2="27" y2="82" />
                        <line x1="50" y1="50" x2="12" y2="38" />
                    </g>
                    <!-- Brake Rotor Slots & Center Cap -->
                    <circle cx="50" cy="50" r="14" fill="#0A0A0C" stroke="currentColor" stroke-width="3"/>
                    <circle cx="50" cy="50" r="5" fill="#E2E8F0"/>
                </svg>
            </div>

            <!-- Branding Title -->
            <div class="text-center space-y-1">
                <h1 class="text-2xl md:text-3xl font-extrabold tracking-widest text-transparent bg-clip-text bg-gradient-to-r from-white via-slate-200 to-slate-400 silver-sweep">
                    POV WHEELS
                </h1>
                <p class="text-xs uppercase tracking-[0.3em] text-slate-400 font-medium">By Sumit Vankar</p>
            </div>

            <!-- Progress Bar -->
            <div class="w-48 h-1 bg-white/10 rounded-full overflow-hidden relative">
                <div id="loader-bar" class="h-full bg-gradient-to-r from-slate-400 via-white to-slate-300 w-0 transition-all duration-300 ease-out"></div>
            </div>
        </div>
    </div>

    <!-- ===================================================================
         BACKGROUND CANVAS & SEAMLESS AUTOMOTIVE MASKING
    ==================================================================== -->
    <canvas id="bg-canvas"></canvas>

    <div class="car-bg-overlay">
        <!-- Mahindra Scorpio Classic Delivery (Top Section) -->
        <div class="car-mask-layer" style="background-image: url('https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=1920&q=80'); top: 5%; height: 35%;"></div>
        <!-- White Toyota Fortuner Dust/Off-road Shot (Mid Section) -->
        <div class="car-mask-layer" style="background-image: url('https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=1920&q=80'); top: 40%; height: 35%;"></div>
        <!-- Fortuner Showroom Delivery (Lower Section) -->
        <div class="car-mask-layer" style="background-image: url('https://images.unsplash.com/photo-1617814076367-b759c7d7e738?auto=format&fit=crop&w=1920&q=80'); top: 70%; height: 30%;"></div>
    </div>

    <!-- ===================================================================
         4. DYNAMIC ISLAND FLOATING NAVBAR
    ==================================================================== -->
    <header class="fixed top-5 inset-x-0 z-50 flex justify-center px-4">
        <nav class="glass-pill rounded-full px-4 py-2.5 flex items-center justify-between w-full max-w-4xl shadow-glass-edge transition-all duration-300">
            <!-- Brand Logo -->
            <a href="#" class="flex items-center space-x-2.5 group">
                <div class="w-9 h-9 rounded-full bg-white/10 border border-white/20 flex items-center justify-center group-hover:border-white/50 transition">
                    <svg class="w-5 h-5 text-slate-100 spin-wheel" viewBox="0 0 100 100" fill="none">
                        <circle cx="50" cy="50" r="44" stroke="currentColor" stroke-width="6"/>
                        <line x1="50" y1="50" x2="50" y2="10" stroke="currentColor" stroke-width="6"/>
                        <line x1="50" y1="50" x2="88" y2="38" stroke="currentColor" stroke-width="6"/>
                        <line x1="50" y1="50" x2="73" y2="82" stroke="currentColor" stroke-width="6"/>
                        <line x1="50" y1="50" x2="27" y2="82" stroke="currentColor" stroke-width="6"/>
                        <line x1="50" y1="50" x2="12" y2="38" stroke="currentColor" stroke-width="6"/>
                        <circle cx="50" cy="50" r="12" fill="#FFFFFF"/>
                    </svg>
                </div>
                <div class="flex flex-col">
                    <span class="font-heading font-extrabold text-sm tracking-wider text-white leading-none">POV WHEELS</span>
                    <span class="text-[10px] text-slate-400 font-medium tracking-tight">SUMIT VANKAR</span>
                </div>
            </a>

            <!-- Navigation Links -->
            <div class="hidden md:flex items-center space-x-6 text-xs font-semibold uppercase tracking-wider text-slate-300">
                <a href="#delivery-spotlight" class="hover:text-white transition">Deliveries</a>
                <a href="#services" class="hover:text-white transition">Services</a>
                <a href="#calculator" class="hover:text-white transition">Pricing</a>
                <a href="#process" class="hover:text-white transition">Process</a>
            </div>

            <!-- Quick Action Buttons -->
            <div class="flex items-center space-x-2">
                <button onclick="openQrModal('upi')" class="px-3 py-1.5 rounded-full bg-white/10 hover:bg-white/20 border border-white/20 text-xs font-semibold text-white flex items-center space-x-1.5 transition">
                    <i class="fa-solid fa-qrcode text-slate-300"></i>
                    <span>Scan QR</span>
                </button>
                <a href="#calculator" class="px-4 py-1.5 rounded-full bg-gradient-to-r from-slate-200 via-white to-slate-300 text-black font-heading font-bold text-xs tracking-wide shadow-silver-glow hover:opacity-95 transition">
                    Book Now
                </a>
            </div>
        </nav>
    </header>

    <!-- ===================================================================
         HERO SECTION
    ==================================================================== -->
    <section class="min-h-screen pt-36 pb-20 px-4 flex flex-col justify-center items-center relative z-10">
        <div class="max-w-4xl mx-auto text-center space-y-8">
            
            <!-- Hero Pill Badge -->
            <div class="reveal-item inline-flex items-center space-x-2 px-4 py-1.5 rounded-full liquid-glass border border-white/20 text-xs text-slate-300 font-medium">
                <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span>
                <span>Automotive Videographer & CapCut Editor</span>
                <span class="text-white/40">|</span>
                <span class="text-emerald-400 font-mono-num font-semibold">4K UHD 60FPS Included</span>
            </div>

            <!-- Main Headline -->
            <h1 class="reveal-item text-4xl sm:text-6xl md:text-7xl font-extrabold tracking-tight text-white leading-tight">
                Cinematic Car & Bike Delivery Shoots.
                <span class="block mt-2 text-transparent bg-clip-text bg-gradient-to-r from-slate-100 via-slate-300 to-slate-500">
                    High Octane CapCut Edits.
                </span>
            </h1>

            <!-- Subtitle -->
            <p class="reveal-item text-base sm:text-lg text-slate-300 max-w-2xl mx-auto font-normal leading-relaxed">
                Empowering car owners, showrooms, and automotive enthusiasts with raw engine sound, crisp color grading, smooth 60fps transitions, and aesthetic reels.
            </p>

            <!-- CTA Buttons -->
            <div class="reveal-item flex flex-col sm:flex-row items-center justify-center gap-4 pt-4">
                <a href="#calculator" class="w-full sm:w-auto px-8 py-4 rounded-2xl bg-white text-black font-heading font-bold text-sm tracking-wide shadow-silver-glow hover:bg-slate-100 transition flex items-center justify-center space-x-2">
                    <i class="fa-solid fa-calculator"></i>
                    <span>Calculate Price & Book</span>
                </a>
                <button onclick="openQrModal('upi')" class="w-full sm:w-auto px-8 py-4 rounded-2xl liquid-glass text-white font-heading font-semibold text-sm hover:bg-white/10 transition flex items-center justify-center space-x-2 border border-white/20">
                    <i class="fa-solid fa-qrcode"></i>
                    <span>Pay ₹100 Advance</span>
                </button>
            </div>

            <!-- Feature Badges Bar -->
            <div class="reveal-item pt-12 grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
                <div class="p-4 rounded-2xl liquid-glass">
                    <div class="text-xl text-slate-200 mb-1"><i class="fa-solid fa-car-side"></i></div>
                    <div class="font-heading font-bold text-sm text-white">Car Unveiling</div>
                    <div class="text-xs text-slate-400">Showroom Deliveries</div>
                </div>
                <div class="p-4 rounded-2xl liquid-glass">
                    <div class="text-xl text-slate-200 mb-1"><i class="fa-solid fa-bolt"></i></div>
                    <div class="font-heading font-bold text-sm text-white">CapCut FX</div>
                    <div class="text-xs text-slate-400">4K 60fps Smooth Beat Sync</div>
                </div>
                <div class="p-4 rounded-2xl liquid-glass">
                    <div class="text-xl text-slate-200 mb-1"><i class="fa-solid fa-[#000]"></i><i class="fa-solid fa-indian-rupee-sign"></i></div>
                    <div class="font-heading font-bold text-sm text-white">₹100 Advance</div>
                    <div class="text-xs text-slate-400">Lock Booking Instantly</div>
                </div>
                <div class="p-4 rounded-2xl liquid-glass">
                    <div class="text-xl text-slate-200 mb-1"><i class="fa-solid fa-clock"></i></div>
                    <div class="font-heading font-bold text-sm text-white">Fast Delivery</div>
                    <div class="text-xs text-slate-400">Quick Turnaround Time</div>
                </div>
            </div>

        </div>
    </section>

    <!-- ===================================================================
         5. CAR DELIVERY SHOOT SPOTLIGHT & PORTFOLIO HIGHLIGHTS
    ==================================================================== -->
    <section id="delivery-spotlight" class="py-24 px-4 max-w-6xl mx-auto relative z-10">
        <div class="text-center space-y-3 mb-16 reveal-item">
            <h2 class="text-xs font-bold uppercase tracking-widest text-slate-400">Signature Showcase</h2>
            <h3 class="text-3xl md:text-5xl font-extrabold text-white">Car & Bike Delivery Shoots</h3>
            <p class="text-slate-300 max-w-xl mx-auto text-sm">Specializing in Mahindra Scorpio Classic, Toyota Fortuner, Thar, and Superbike showroom unveilings & key handovers.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <!-- Card 1: Mahindra Scorpio Classic -->
            <div class="liquid-glass rounded-3xl p-6 relative group overflow-hidden reveal-item">
                <div class="aspect-video w-full rounded-2xl bg-black/50 overflow-hidden relative mb-5 border border-white/10">
                    <img src="https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=800&q=80" alt="Mahindra Scorpio Classic Delivery" class="w-full h-full object-cover group-hover:scale-105 transition duration-700">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
                    <span class="absolute top-3 left-3 px-3 py-1 rounded-full bg-black/60 backdrop-blur-md text-[10px] font-mono-num text-slate-200 border border-white/20">Delivery Shoot</span>
                </div>
                <h4 class="text-xl font-bold text-white mb-2">Mahindra Scorpio Classic</h4>
                <p class="text-xs text-slate-300 leading-relaxed mb-4">
                    Showroom key handover, red & white flower garland unveiling, deep exhaust roar audio capture, cinematic slow-motion wheel rolls.
                </p>
                <div class="flex items-center justify-between pt-3 border-t border-white/10 text-xs font-mono-num text-slate-400">
                    <span><i class="fa-solid fa-video text-slate-300 mr-1"></i> CapCut Color Graded</span>
                    <span class="text-emerald-400 font-semibold">4K 60fps</span>
                </div>
            </div>

            <!-- Card 2: White Toyota Fortuner -->
            <div class="liquid-glass rounded-3xl p-6 relative group overflow-hidden reveal-item">
                <div class="aspect-video w-full rounded-2xl bg-black/50 overflow-hidden relative mb-5 border border-white/10">
                    <img src="https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=800&q=80" alt="White Toyota Fortuner Off-Road" class="w-full h-full object-cover group-hover:scale-105 transition duration-700">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
                    <span class="absolute top-3 left-3 px-3 py-1 rounded-full bg-black/60 backdrop-blur-md text-[10px] font-mono-num text-slate-200 border border-white/20">Off-Road & Highway</span>
                </div>
                <h4 class="text-xl font-bold text-white mb-2">White Toyota Fortuner</h4>
                <p class="text-xs text-slate-300 leading-relaxed mb-4">
                    High-speed highway tracking shots, dust-drift aesthetics, muscular stance angles, synchronized bass-drop CapCut transitions.
                </p>
                <div class="flex items-center justify-between pt-3 border-t border-white/10 text-xs font-mono-num text-slate-400">
                    <span><i class="fa-solid fa-sliders text-slate-300 mr-1"></i> Sound Design</span>
                    <span class="text-emerald-400 font-semibold">4K 60fps</span>
                </div>
            </div>

            <!-- Card 3: Superbike & Car Edit -->
            <div class="liquid-glass rounded-3xl p-6 relative group overflow-hidden reveal-item">
                <div class="aspect-video w-full rounded-2xl bg-black/50 overflow-hidden relative mb-5 border border-white/10">
                    <img src="https://images.unsplash.com/photo-1558981806-ec527fa84c39?auto=format&fit=crop&w=800&q=80" alt="Superbike Edit" class="w-full h-full object-cover group-hover:scale-105 transition duration-700">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent"></div>
                    <span class="absolute top-3 left-3 px-3 py-1 rounded-full bg-black/60 backdrop-blur-md text-[10px] font-mono-num text-slate-200 border border-white/20">Raw Video Editing</span>
                </div>
                <h4 class="text-xl font-bold text-white mb-2">CapCut Editing Specialist</h4>
                <p class="text-xs text-slate-300 leading-relaxed mb-4">
                    Send your raw footage via Google Drive or Telegram. We polish, speed-ramp, add text overlays, and sync music seamlessly.
                </p>
                <div class="flex items-center justify-between pt-3 border-t border-white/10 text-xs font-mono-num text-slate-400">
                    <span><i class="fa-solid fa-cloud-arrow-up text-slate-300 mr-1"></i> Remote Editing</span>
                    <span class="text-emerald-400 font-semibold">Any Device</span>
                </div>
            </div>
        </div>

        <!-- Google Drive Direct Link Button -->
        <div class="text-center mt-12 reveal-item">
            <a href="https://drive.google.com/drive/folders/1pPCBK9pncprwYTuRSyDfKAM8uGTvpSDn" target="_blank" rel="noopener" class="inline-flex items-center space-x-3 px-6 py-3 rounded-full bg-white/10 hover:bg-white/20 border border-white/20 text-xs font-semibold text-white transition">
                <i class="fa-solid fa-folder-open text-amber-400 text-sm"></i>
                <span>Explore Full Video Portfolio on Google Drive</span>
                <i class="fa-solid fa-arrow-up-right-from-square text-xs opacity-60"></i>
            </a>
        </div>
    </section>

    <!-- ===================================================================
         SERVICES OVERVIEW
    ==================================================================== -->
    <section id="services" class="py-20 px-4 max-w-6xl mx-auto relative z-10">
        <div class="text-center space-y-3 mb-16 reveal-item">
            <h2 class="text-xs font-bold uppercase tracking-widest text-slate-400">What We Offer</h2>
            <h3 class="text-3xl md:text-5xl font-extrabold text-white">Automotive Production Services</h3>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Service 1 -->
            <div class="liquid-glass rounded-3xl p-6 space-y-4 reveal-item">
                <div class="w-12 h-12 rounded-2xl bg-white/10 flex items-center justify-center text-white text-xl border border-white/15">
                    <i class="fa-solid fa-car-rear"></i>
                </div>
                <h4 class="text-lg font-bold text-white">Car Unveiling & Delivery</h4>
                <p class="text-xs text-slate-300 leading-relaxed">
                    Capture the emotional moment of taking delivery of your new car from the showroom with family, flower garland removal, and first start rev.
                </p>
            </div>

            <!-- Service 2 -->
            <div class="liquid-glass rounded-3xl p-6 space-y-4 reveal-item">
                <div class="w-12 h-12 rounded-2xl bg-white/10 flex items-center justify-center text-white text-xl border border-white/15">
                    <i class="fa-solid fa-motorcycle"></i>
                </div>
                <h4 class="text-lg font-bold text-white">Superbike & Bike Shoots</h4>
                <p class="text-xs text-slate-300 leading-relaxed">
                    Dynamic angle shots, exhaust note audio recording, helmet cam integration, and aggressive cinematic reel edits.
                </p>
            </div>

            <!-- Service 3 -->
            <div class="liquid-glass rounded-3xl p-6 space-y-4 reveal-item">
                <div class="w-12 h-12 rounded-2xl bg-white/10 flex items-center justify-center text-white text-xl border border-white/15">
                    <i class="fa-solid fa-wand-magic-sparkles"></i>
                </div>
                <h4 class="text-lg font-bold text-white">CapCut Reel Editing</h4>
                <p class="text-xs text-slate-300 leading-relaxed">
                    Expert mobile & desktop CapCut video editing with speed ramping, optical flow smooth motion, LUT color grading, and trending audio sync.
                </p>
            </div>
        </div>
    </section>

    <!-- ===================================================================
         PACKAGE & PRICING CALCULATOR (NO EXTRA CHARGE FOR 4K)
    ==================================================================== -->
    <section id="calculator" class="py-24 px-4 max-w-4xl mx-auto relative z-10">
        <div class="liquid-glass rounded-3xl p-6 sm:p-10 border border-white/20 shadow-glass-edge reveal-item">
            
            <div class="text-center space-y-2 mb-8">
                <span class="px-3 py-1 rounded-full bg-white/10 text-xs text-slate-300 border border-white/20 font-mono-num">Official Rate Card</span>
                <h2 class="text-2xl sm:text-4xl font-extrabold text-white">Live Package & Quote Calculator</h2>
                <p class="text-xs sm:text-sm text-slate-300">Select your package, duration, and resolution to get an instant price breakdown.</p>
            </div>

            <div class="space-y-8">
                <!-- STEP 1: Select Main Package -->
                <div class="space-y-3">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-300">1. Select Shoot / Edit Service</label>
                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-3">
                        <!-- Option A: Only Editing -->
                        <label class="cursor-pointer">
                            <input type="radio" name="package" value="799" class="peer hidden" onchange="calculateTotal()" checked>
                            <div class="p-4 rounded-2xl bg-white/5 border border-white/10 peer-checked:border-white peer-checked:bg-white/15 transition flex flex-col justify-between h-full">
                                <div>
                                    <div class="font-heading font-bold text-sm text-white">Only Video Editing</div>
                                    <div class="text-[11px] text-slate-400 mt-1">Raw footage provided by client</div>
                                </div>
                                <div class="mt-4 font-mono-num font-extrabold text-lg text-white">₹799</div>
                            </div>
                        </label>

                        <!-- Option B: Bike Shoot + Edit -->
                        <label class="cursor-pointer">
                            <input type="radio" name="package" value="1499" class="peer hidden" onchange="calculateTotal()">
                            <div class="p-4 rounded-2xl bg-white/5 border border-white/10 peer-checked:border-white peer-checked:bg-white/15 transition flex flex-col justify-between h-full">
                                <div>
                                    <div class="font-heading font-bold text-sm text-white">Bike Shoot + Edit</div>
                                    <div class="text-[11px] text-slate-400 mt-1">On-location shoot & full edit</div>
                                </div>
                                <div class="mt-4 font-mono-num font-extrabold text-lg text-white">₹1,499</div>
                            </div>
                        </label>

                        <!-- Option C: Car Shoot + Edit -->
                        <label class="cursor-pointer">
                            <input type="radio" name="package" value="1999" class="peer hidden" onchange="calculateTotal()">
                            <div class="p-4 rounded-2xl bg-white/5 border border-white/10 peer-checked:border-white peer-checked:bg-white/15 transition flex flex-col justify-between h-full">
                                <div>
                                    <div class="font-heading font-bold text-sm text-white">Car Shoot + Edit</div>
                                    <div class="text-[11px] text-slate-400 mt-1">Showroom delivery / On-road shoot</div>
                                </div>
                                <div class="mt-4 font-mono-num font-extrabold text-lg text-white">₹1,999</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- STEP 2: Select Duration -->
                <div class="space-y-3">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-300">2. Select Reel Length</label>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                        <label class="cursor-pointer">
                            <input type="radio" name="duration" value="0" class="peer hidden" onchange="calculateTotal()" checked>
                            <div class="p-3.5 rounded-2xl bg-white/5 border border-white/10 peer-checked:border-white peer-checked:bg-white/15 transition flex justify-between items-center">
                                <div>
                                    <span class="font-heading font-semibold text-xs text-white">15 Seconds - 30 Seconds</span>
                                    <span class="block text-[10px] text-slate-400">Standard Reel Format</span>
                                </div>
                                <span class="text-xs font-mono-num font-bold text-emerald-400">Included (₹0)</span>
                            </div>
                        </label>

                        <label class="cursor-pointer">
                            <input type="radio" name="duration" value="100" class="peer hidden" onchange="calculateTotal()">
                            <div class="p-3.5 rounded-2xl bg-white/5 border border-white/10 peer-checked:border-white peer-checked:bg-white/15 transition flex justify-between items-center">
                                <div>
                                    <span class="font-heading font-semibold text-xs text-white">31 Seconds - 50 Seconds Max</span>
                                    <span class="block text-[10px] text-slate-400">Extended Cinematic Cut</span>
                                </div>
                                <span class="text-xs font-mono-num font-bold text-white">+₹100</span>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- STEP 3: Select Resolution (NO EXTRA CHARGE FOR 4K) -->
                <div class="space-y-3">
                    <label class="block text-xs font-bold uppercase tracking-wider text-slate-300">3. Video Resolution & Frame Rate</label>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                        <label class="cursor-pointer">
                            <input type="radio" name="resolution" value="0" class="peer hidden" onchange="calculateTotal()" checked>
                            <div class="p-3.5 rounded-2xl bg-white/5 border border-white/10 peer-checked:border-white peer-checked:bg-white/15 transition flex justify-between items-center">
                                <div>
                                    <span class="font-heading font-semibold text-xs text-white">1080p Full HD (60fps)</span>
                                    <span class="block text-[10px] text-slate-400">Crisp for Instagram</span>
                                </div>
                                <span class="text-xs font-mono-num font-bold text-emerald-400">FREE / Included</span>
                            </div>
                        </label>

                        <label class="cursor-pointer">
                            <input type="radio" name="resolution" value="0" class="peer hidden" onchange="calculateTotal()">
                            <div class="p-3.5 rounded-2xl bg-white/5 border border-white/10 peer-checked:border-white peer-checked:bg-white/15 transition flex justify-between items-center">
                                <div>
                                    <span class="font-heading font-semibold text-xs text-white">4K UHD Ultra HD (60fps)</span>
                                    <span class="block text-[10px] text-slate-400">Maximum Clarity & Bitrate</span>
                                </div>
                                <span class="text-xs font-mono-num font-bold text-emerald-400">FREE / Included (₹0)</span>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- LIVE BREAKDOWN DISPLAY BOX -->
                <div class="rounded-2xl bg-black/60 border border-white/15 p-5 space-y-3 font-mono-num">
                    <div class="flex justify-between items-center text-xs text-slate-300">
                        <span>Selected Package Total:</span>
                        <span id="calc-package-price" class="text-white font-bold">₹799</span>
                    </div>
                    <div class="flex justify-between items-center text-xs text-slate-300">
                        <span>Duration Surcharge:</span>
                        <span id="calc-duration-price" class="text-white">₹0</span>
                    </div>
                    <div class="flex justify-between items-center text-xs text-slate-300">
                        <span>4K Ultra HD 60fps Upgrade:</span>
                        <span class="text-emerald-400 font-bold">Included (₹0)</span>
                    </div>
                    <div class="border-t border-white/10 pt-3 flex justify-between items-center text-sm font-bold text-white">
                        <span>Total Estimated Amount:</span>
                        <span id="calc-total" class="text-xl text-emerald-400">₹799</span>
                    </div>
                    <div class="bg-white/5 p-3 rounded-xl flex justify-between items-center text-xs text-slate-300 mt-2">
                        <span>Booking Advance Required:</span>
                        <span class="text-amber-400 font-bold">₹100 (To Lock Slot)</span>
                    </div>
                    <div class="flex justify-between items-center text-[11px] text-slate-400">
                        <span>Remaining Balance:</span>
                        <span id="calc-balance" class="text-slate-200">₹699 (Pay on First Draft)</span>
                    </div>
                </div>

                <!-- ACTION BUTTONS -->
                <div class="flex flex-col sm:flex-row gap-3 pt-2">
                    <button onclick="sendWhatsAppQuote()" class="flex-1 py-4 rounded-2xl bg-emerald-500 hover:bg-emerald-400 text-black font-heading font-bold text-sm tracking-wide transition flex items-center justify-center space-x-2 shadow-lg shadow-emerald-950/40">
                        <i class="fa-brands fa-whatsapp text-lg"></i>
                        <span>Book & Send Quote on WhatsApp</span>
                    </button>
                    <button onclick="openQrModal('upi')" class="py-4 px-6 rounded-2xl bg-white/10 hover:bg-white/20 border border-white/20 text-white font-heading font-semibold text-sm transition flex items-center justify-center space-x-2">
                        <i class="fa-solid fa-qrcode"></i>
                        <span>Pay ₹100 Advance</span>
                    </button>
                </div>

            </div>
        </div>
    </section>

    <!-- ===================================================================
         6. STEP-BY-STEP WORKING PROCESS
    ==================================================================== -->
    <section id="process" class="py-20 px-4 max-w-6xl mx-auto relative z-10">
        <div class="text-center space-y-3 mb-16 reveal-item">
            <h2 class="text-xs font-bold uppercase tracking-widest text-slate-400">Seamless Workflow</h2>
            <h3 class="text-3xl md:text-5xl font-extrabold text-white">6 Simple Steps to Your Reel</h3>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            <!-- Step 1 -->
            <div class="liquid-glass rounded-3xl p-6 relative reveal-item">
                <span class="text-3xl font-mono-num font-extrabold text-white/20 absolute top-4 right-6">01</span>
                <h4 class="text-base font-bold text-white mb-2">Share Requirements</h4>
                <p class="text-xs text-slate-300">Contact via WhatsApp with details of your car/bike delivery location or raw footage Google Drive link.</p>
            </div>

            <!-- Step 2 -->
            <div class="liquid-glass rounded-3xl p-6 relative reveal-item">
                <span class="text-3xl font-mono-num font-extrabold text-white/20 absolute top-4 right-6">02</span>
                <h4 class="text-base font-bold text-white mb-2">Confirm Package & Date</h4>
                <p class="text-xs text-slate-300">Finalize the video length, music style, and shoot timing with Sumit Vankar.</p>
            </div>

            <!-- Step 3 -->
            <div class="liquid-glass rounded-3xl p-6 relative reveal-item">
                <span class="text-3xl font-mono-num font-extrabold text-white/20 absolute top-4 right-6">03</span>
                <h4 class="text-base font-bold text-white mb-2">₹100 Advance Received</h4>
                <p class="text-xs text-slate-300">Pay ₹100 token advance via Google Pay / PhonePe UPI to lock your date and start processing.</p>
            </div>

            <!-- Step 4 -->
            <div class="liquid-glass rounded-3xl p-6 relative reveal-item">
                <span class="text-3xl font-mono-num font-extrabold text-white/20 absolute top-4 right-6">04</span>
                <h4 class="text-base font-bold text-white mb-2">Shoot & CapCut Editing</h4>
                <p class="text-xs text-slate-300">On-location filming or remote CapCut editing with color grading, sound design, and smooth cuts.</p>
            </div>

            <!-- Step 5 -->
            <div class="liquid-glass rounded-3xl p-6 relative reveal-item">
                <span class="text-3xl font-mono-num font-extrabold text-white/20 absolute top-4 right-6">05</span>
                <h4 class="text-base font-bold text-white mb-2">First Draft Preview</h4>
                <p class="text-xs text-slate-300">Receive draft preview for review. Minor adjustments or song tweaks applied if needed.</p>
            </div>

            <!-- Step 6 -->
            <div class="liquid-glass rounded-3xl p-6 relative reveal-item">
                <span class="text-3xl font-mono-num font-extrabold text-white/20 absolute top-4 right-6">06</span>
                <h4 class="text-base font-bold text-white mb-2">Final Payment & Delivery</h4>
                <p class="text-xs text-slate-300">Pay remaining balance and receive your high-bitrate 4K 60fps MP4 video file ready for Instagram Reels.</p>
            </div>
        </div>
    </section>

    <!-- ===================================================================
         7. TERMS, POLICIES & IMPORTANT NOTES
    ==================================================================== -->
    <section class="py-16 px-4 max-w-4xl mx-auto relative z-10">
        <div class="liquid-glass rounded-3xl p-6 sm:p-8 space-y-6 reveal-item">
            <h3 class="text-xl font-bold text-white flex items-center space-x-2">
                <i class="fa-solid fa-circle-info text-amber-400"></i>
                <span>Client Terms & Guidelines</span>
            </h3>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-xs text-slate-300 leading-relaxed">
                <div class="p-4 rounded-2xl bg-white/5 border border-white/10 space-y-1">
                    <span class="font-bold text-white block">🎵 Music & Audio Confirmation</span>
                    <p>Song choice must be finalized before editing starts. Song changes after the complete video edit will incur a small re-edit charge.</p>
                </div>

                <div class="p-4 rounded-2xl bg-white/5 border border-white/10 space-y-1">
                    <span class="font-bold text-white block">🎥 Reference Reels Accepted</span>
                    <p>Feel free to share any Instagram Reel link as reference for style, beat sync, or color mood before shooting.</p>
                </div>

                <div class="p-4 rounded-2xl bg-white/5 border border-white/10 space-y-1">
                    <span class="font-bold text-white block">💳 Payment Methods Accepted</span>
                    <p>Google Pay, PhonePe, Paytm, BHIM UPI (`sumitvankar21-1@oksbi`), and direct Bank Transfer.</p>
                </div>

                <div class="p-4 rounded-2xl bg-white/5 border border-white/10 space-y-1">
                    <span class="font-bold text-white block">⚡ Fast Turnaround Time</span>
                    <p>Edits are generally delivered within 24-48 hours after shoot completion or raw file upload.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- ===================================================================
         FOOTER & CONTACT DETAILS
    ==================================================================== -->
    <footer class="py-16 px-4 border-t border-white/10 relative z-10 bg-black/80">
        <div class="max-w-6xl mx-auto flex flex-col md:flex-row items-center justify-between gap-8 text-center md:text-left">
            
            <div class="space-y-2">
                <div class="flex items-center justify-center md:justify-start space-x-3">
                    <div class="w-8 h-8 rounded-full bg-white/10 flex items-center justify-center text-white border border-white/20">
                        <i class="fa-solid fa-car"></i>
                    </div>
                    <span class="font-heading font-extrabold text-lg text-white tracking-wider">POV WHEELS</span>
                </div>
                <p class="text-xs text-slate-400">Automotive Videography & CapCut Edits by Sumit Vankar</p>
                <p class="text-[11px] font-mono-num text-slate-500">Email: sumitvankar21@gmail.com | Phone: +91 70167 20163</p>
            </div>

            <div class="flex flex-wrap justify-center gap-3">
                <a href="https://wa.me/917016720163" target="_blank" class="px-4 py-2 rounded-full bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 hover:bg-emerald-500 hover:text-black text-xs font-semibold transition flex items-center space-x-2">
                    <i class="fa-brands fa-whatsapp text-sm"></i>
                    <span>+91 70167 20163</span>
                </a>
                <a href="https://instagram.com/Povwheels" target="_blank" class="px-4 py-2 rounded-full bg-pink-500/10 border border-pink-500/30 text-pink-400 hover:bg-pink-500 hover:text-white text-xs font-semibold transition flex items-center space-x-2">
                    <i class="fa-brands fa-instagram text-sm"></i>
                    <span>@Povwheels</span>
                </a>
                <button onclick="openQrModal('upi')" class="px-4 py-2 rounded-full bg-white/10 hover:bg-white/20 border border-white/20 text-white text-xs font-semibold transition flex items-center space-x-2">
                    <i class="fa-solid fa-qrcode text-amber-400"></i>
                    <span>Pay ₹100 UPI</span>
                </button>
            </div>

        </div>

        <div class="max-w-6xl mx-auto mt-10 pt-6 border-t border-white/5 text-center text-xs text-slate-500 font-mono-num">
            © 2026 POV Wheels by Sumit Vankar. All rights reserved. Built with Liquid Glass Architecture.
        </div>
    </footer>

    <!-- ===================================================================
         FLOATING BOTTOM-RIGHT SCAN QR BUTTON
    ==================================================================== -->
    <div class="fixed bottom-6 right-6 z-40">
        <button onclick="openQrModal('upi')" class="glass-pill p-3.5 rounded-full text-white hover:scale-110 active:scale-95 transition shadow-silver-glow flex items-center justify-center border border-white/30 group">
            <i class="fa-solid fa-qrcode text-xl group-hover:rotate-12 transition duration-300"></i>
            <span class="max-w-0 overflow-hidden group-hover:max-w-xs transition-all duration-300 ease-in-out whitespace-nowrap text-xs font-bold pl-0 group-hover:pl-2">
                Scan QR & Pay
            </span>
        </button>
    </div>

    <!-- ===================================================================
         6. TAP-TO-OPEN 4-IN-1 QR HUB MODAL
    ==================================================================== -->
    <div id="qr-modal" class="fixed inset-0 z-50 bg-black/80 backdrop-blur-md hidden flex items-center justify-center p-4 transition-all duration-300 opacity-0">
        <div class="liquid-glass w-full max-w-md rounded-3xl p-6 relative border border-white/20 shadow-2xl scale-95 transition-all duration-300" id="qr-modal-card">
            
            <!-- Modal Close Button -->
            <button onclick="closeQrModal()" class="absolute top-4 right-4 w-9 h-9 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center text-white transition">
                <i class="fa-solid fa-xmark"></i>
            </button>

            <!-- Header -->
            <div class="text-center space-y-1 mb-5">
                <h3 class="text-xl font-bold text-white font-heading">POV Wheels QR Hub</h3>
                <p class="text-xs text-slate-400">Select a tab below to generate QR & Links</p>
            </div>

            <!-- Tab Navigation Buttons -->
            <div class="grid grid-cols-4 gap-1 bg-white/5 p-1 rounded-2xl border border-white/10 mb-5 text-[11px] font-semibold text-center">
                <button onclick="switchQrTab('upi')" id="tab-btn-upi" class="py-2 rounded-xl transition text-white bg-white/20">₹100 UPI</button>
                <button onclick="switchQrTab('whatsapp')" id="tab-btn-whatsapp" class="py-2 rounded-xl transition text-slate-400 hover:text-white">WhatsApp</button>
                <button onclick="switchQrTab('instagram')" id="tab-btn-instagram" class="py-2 rounded-xl transition text-slate-400 hover:text-white">Instagram</button>
                <button onclick="switchQrTab('drive')" id="tab-btn-drive" class="py-2 rounded-xl transition text-slate-400 hover:text-white">Drive</button>
            </div>

            <!-- Dynamic QR Container -->
            <div class="bg-white rounded-2xl p-5 flex flex-col items-center justify-center shadow-inner relative">
                <div id="qrcode-box" class="w-48 h-48 flex items-center justify-center"></div>
            </div>

            <!-- Content Details area -->
            <div id="qr-details" class="mt-4 text-center space-y-3 font-mono-num">
                <!-- Dynamically Populated by JS -->
            </div>

        </div>
    </div>

    <!-- ===================================================================
         TOAST NOTIFICATION BOX
    ==================================================================== -->
    <div id="toast" class="glass-pill px-5 py-3 rounded-2xl text-xs font-semibold text-white flex items-center space-x-2 border border-white/30 shadow-2xl">
        <i class="fa-solid fa-circle-check text-emerald-400 text-sm"></i>
        <span id="toast-msg">Copied to clipboard!</span>
    </div>

    <!-- ===================================================================
         JAVASCRIPT LOGIC & ANIMATIONS
    ==================================================================== -->
    <script>
        // -----------------------------------------------------------------
        // 1. PRELOADER & STAGGERED REVEAL
        // -----------------------------------------------------------------
        window.addEventListener('load', () => {
            const bar = document.getElementById('loader-bar');
            bar.style.width = '100%';
            
            setTimeout(() => {
                const preloader = document.getElementById('preloader');
                preloader.classList.add('loaded');
                
                // Trigger Scroll Reveal items
                triggerReveals();
            }, 1200);
        });

        function triggerReveals() {
            const reveals = document.querySelectorAll('.reveal-item');
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('active');
                    }
                });
            }, { threshold: 0.1 });

            reveals.forEach(el => observer.observe(el));
        }

        // -----------------------------------------------------------------
        // 2. 60FPS METALLIC SHINE SILVER LIQUID WAVE CANVAS
        // -----------------------------------------------------------------
        const canvas = document.getElementById('bg-canvas');
        const ctx = canvas.getContext('2d');
        let width = canvas.width = window.innerWidth;
        let height = canvas.height = window.innerHeight;

        window.addEventListener('resize', () => {
            width = canvas.width = window.innerWidth;
            height = canvas.height = window.innerHeight;
        });

        let step = 0;
        function animateCanvas() {
            ctx.clearRect(0, 0, width, height);
            step += 0.008;

            const waveCount = 3;
            for (let i = 0; i < waveCount; i++) {
                ctx.beginPath();
                ctx.moveTo(0, height);

                for (let x = 0; x <= width; x += 20) {
                    const y = Math.sin(x * 0.003 + step + i * 1.5) * 40 +
                              Math.cos(x * 0.001 + step * 0.8) * 60 +
                              height * (0.4 + i * 0.2);
                    ctx.lineTo(x, y);
                }

                ctx.lineTo(width, height);
                ctx.closePath();

                const grad = ctx.createLinearGradient(0, 0, width, height);
                if (i === 0) {
                    grad.addColorStop(0, 'rgba(255, 255, 255, 0.03)');
                    grad.addColorStop(0.5, 'rgba(160, 174, 192, 0.05)');
                    grad.addColorStop(1, 'rgba(0, 0, 0, 0.8)');
                } else if (i === 1) {
                    grad.addColorStop(0, 'rgba(200, 200, 220, 0.02)');
                    grad.addColorStop(0.7, 'rgba(30, 41, 59, 0.08)');
                    grad.addColorStop(1, 'rgba(0, 0, 0, 0.9)');
                } else {
                    grad.addColorStop(0, 'rgba(255, 255, 255, 0.01)');
                    grad.addColorStop(1, 'rgba(5, 5, 5, 0.95)');
                }

                ctx.fillStyle = grad;
                ctx.fill();
            }

            requestAnimationFrame(animateCanvas);
        }
        animateCanvas();

        // -----------------------------------------------------------------
        // 3. PRICING CALCULATOR LOGIC
        // -----------------------------------------------------------------
        function calculateTotal() {
            const pkg = parseInt(document.querySelector('input[name="package"]:checked').value);
            const dur = parseInt(document.querySelector('input[name="duration"]:checked').value);
            const total = pkg + dur;
            const balance = total - 100;

            document.getElementById('calc-package-price').innerText = `₹${pkg.toLocaleString()}`;
            document.getElementById('calc-duration-price').innerText = `₹${dur}`;
            document.getElementById('calc-total').innerText = `₹${total.toLocaleString()}`;
            document.getElementById('calc-balance').innerText = `₹${balance.toLocaleString()} (Pay on First Draft)`;
        }

        function sendWhatsAppQuote() {
            const pkgElement = document.querySelector('input[name="package"]:checked').parentElement;
            const pkgName = pkgElement.querySelector('.font-heading').innerText;
            const pkgPrice = document.querySelector('input[name="package"]:checked').value;
            const durExtra = document.querySelector('input[name="duration"]:checked').value;
            const durText = durExtra === "0" ? "15s - 30s (Included)" : "31s - 50s (+₹100)";
            const resText = "4K Ultra HD 60fps (FREE / Included)";

            const total = parseInt(pkgPrice) + parseInt(durExtra);
            const balance = total - 100;

            const text = `Hi Sumit Vankar! I would like to book a shoot/edit from POV Wheels.\n\n` +
                         `📋 *PACKAGE QUOTE DETAILS:*\n` +
                         `• Service: ${pkgName} (₹${pkgPrice})\n` +
                         `• Duration: ${durText}\n` +
                         `• Resolution: ${resText}\n\n` +
                         `💰 *PAYMENT BREAKDOWN:*\n` +
                         `• Total Amount: ₹${total}\n` +
                         `• Booking Advance: ₹100\n` +
                         `• Balance Due on Draft: ₹${balance}\n\n` +
                         `Please confirm available dates for the shoot!`;

            const encoded = encodeURIComponent(text);
            window.open(`https://wa.me/917016720163?text=${encoded}`, '_blank');
        }

        // -----------------------------------------------------------------
        // 4. TAP-TO-OPEN 4-IN-1 QR HUB MODAL (QRCode.js)
        // -----------------------------------------------------------------
        let qrInstance = null;
        let activeTab = 'upi';

        function openQrModal(tab = 'upi') {
            const modal = document.getElementById('qr-modal');
            const card = document.getElementById('qr-modal-card');
            
            modal.classList.remove('hidden');
            setTimeout(() => {
                modal.classList.remove('opacity-0');
                card.classList.remove('scale-95');
                card.classList.add('scale-100');
            }, 10);

            switchQrTab(tab);
        }

        function closeQrModal() {
            const modal = document.getElementById('qr-modal');
            const card = document.getElementById('qr-modal-card');

            card.classList.remove('scale-100');
            card.classList.add('scale-95');
            modal.classList.add('opacity-0');

            setTimeout(() => {
                modal.classList.add('hidden');
            }, 300);
        }

        function switchQrTab(tab) {
            activeTab = tab;
            
            // Highlight Tab Buttons
            ['upi', 'whatsapp', 'instagram', 'drive'].forEach(t => {
                const btn = document.getElementById(`tab-btn-${t}`);
                if (t === tab) {
                    btn.className = 'py-2 rounded-xl transition text-white bg-white/20 shadow';
                } else {
                    btn.className = 'py-2 rounded-xl transition text-slate-400 hover:text-white';
                }
            });

            // Clear old QR
            const qrcodeBox = document.getElementById('qrcode-box');
            qrcodeBox.innerHTML = '';

            let payload = '';
            let detailsHtml = '';

            if (tab === 'upi') {
                const upiId = 'sumitvankar21-1@oksbi';
                payload = `upi://pay?pa=${upiId}&pn=Sumit%20Vankar&am=100&cu=INR`;
                detailsHtml = `
                    <div class="text-xs text-slate-300">Name: <span class="text-white font-bold">Sumit Vankar</span></div>
                    <div class="text-xs text-slate-300">UPI ID: <span class="text-emerald-400 font-bold select-all">${upiId}</span></div>
                    <div class="text-[11px] text-slate-400">Advance Amount: <span class="text-amber-400 font-bold">₹100</span></div>
                    <div class="flex gap-2 pt-2">
                        <button onclick="copyToClipboard('${upiId}', 'UPI ID Copied!')" class="flex-1 py-2 rounded-xl bg-white/10 hover:bg-white/20 border border-white/20 text-xs font-semibold text-white transition">
                            <i class="fa-regular fa-copy mr-1"></i> Copy UPI
                        </button>
                        <a href="${payload}" class="flex-1 py-2 rounded-xl bg-emerald-500 hover:bg-emerald-400 text-black text-xs font-bold transition flex items-center justify-center">
                            Pay ₹100 via UPI
                        </a>
                    </div>
                `;
            } else if (tab === 'whatsapp') {
                payload = 'https://wa.me/917016720163?text=Hi%20Sumit!%20I%20want%20to%20book%20a%20Car/Bike%20Delivery%20Shoot.';
                detailsHtml = `
                    <div class="text-xs text-slate-300">WhatsApp: <span class="text-emerald-400 font-bold">+91 70167 20163</span></div>
                    <div class="text-[11px] text-slate-400">Direct Booking & Queries</div>
                    <div class="pt-2">
                        <a href="${payload}" target="_blank" class="w-full py-2 rounded-xl bg-emerald-500 hover:bg-emerald-400 text-black text-xs font-bold transition flex items-center justify-center space-x-1">
                            <i class="fa-brands fa-whatsapp"></i>
                            <span>Open WhatsApp Chat</span>
                        </a>
                    </div>
                `;
            } else if (tab === 'instagram') {
                payload = 'https://instagram.com/Povwheels';
                detailsHtml = `
                    <div class="text-xs text-slate-300">Instagram Handle: <span class="text-pink-400 font-bold">@Povwheels</span></div>
                    <div class="text-[11px] text-slate-400">Check out latest reels & stories</div>
                    <div class="pt-2">
                        <a href="${payload}" target="_blank" class="w-full py-2 rounded-xl bg-gradient-to-r from-purple-500 to-pink-500 text-white text-xs font-bold transition flex items-center justify-center space-x-1">
                            <i class="fa-brands fa-instagram"></i>
                            <span>Visit Instagram Profile</span>
                        </a>
                    </div>
                `;
            } else if (tab === 'drive') {
                payload = 'https://drive.google.com/drive/folders/1pPCBK9pncprwYTuRSyDfKAM8uGTvpSDn';
                detailsHtml = `
                    <div class="text-xs text-slate-300">Google Drive: <span class="text-amber-400 font-bold">4K Reel Portfolio</span></div>
                    <div class="text-[11px] text-slate-400">View raw & edited high quality clips</div>
                    <div class="pt-2">
                        <a href="${payload}" target="_blank" class="w-full py-2 rounded-xl bg-white/10 hover:bg-white/20 border border-white/20 text-white text-xs font-bold transition flex items-center justify-center space-x-1">
                            <i class="fa-solid fa-folder-open text-amber-400"></i>
                            <span>Open Drive Folder</span>
                        </a>
                    </div>
                `;
            }

            // Generate QRCode
            qrInstance = new QRCode(qrcodeBox, {
                text: payload,
                width: 180,
                height: 180,
                colorDark : "#000000",
                colorLight : "#ffffff",
                correctLevel : QRCode.CorrectLevel.H
            });

            document.getElementById('qr-details').innerHTML = detailsHtml;
        }

        // Helper Copy Function
        function copyToClipboard(text, msg = 'Copied to clipboard!') {
            const tempInput = document.createElement('input');
            tempInput.value = text;
            document.body.appendChild(tempInput);
            tempInput.select();
            document.execCommand('copy');
            document.body.removeChild(tempInput);

            showToast(msg);
        }

        function showToast(msg) {
            const toast = document.getElementById('toast');
            document.getElementById('toast-msg').innerText = msg;
            toast.classList.add('show');
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }
    </script>
</body>
</html>
```
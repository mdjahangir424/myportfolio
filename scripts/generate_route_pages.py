from pathlib import Path
import re
import html

ROUTES = {
    "about": ("About | Md Jahangir Alam", "Learn about Md Jahangir Alam, Flutter Developer and AI Automation Specialist."),
    "skills": ("Skills | Md Jahangir Alam", "Explore Flutter, Dart, Android, iOS, web development, and AI automation skills."),
    "services": ("Services | Md Jahangir Alam", "Explore Flutter app development, web development, and AI automation services."),
    "projects": ("Projects | Md Jahangir Alam", "Browse projects and applications showcased in Md Jahangir Alam's portfolio."),
    "automation": ("AI Automation | Md Jahangir Alam", "Explore AI agents and workflow automation solutions by Md Jahangir Alam."),
    "contact": ("Contact | Md Jahangir Alam", "Contact Md Jahangir Alam about Flutter development and AI automation."),
}

def replace(pattern, value, text, label):
    updated, count = re.subn(pattern, lambda _: value, text, count=1, flags=re.I)
    if count != 1:
        raise RuntimeError(f"Expected one {label}; found {count}")
    return updated

def main():
    root = Path("build/web")
    source = root / "index.html"
    if not source.exists():
        raise FileNotFoundError(source)
    template = source.read_text(encoding="utf-8")
    canonical_origin = "https://myportfolio-f6cfb.web.app"

    for route, (title, description) in ROUTES.items():
        url = f"{canonical_origin}/{route}"
        page = template
        page = replace(r"<title>.*?</title>", f"<title>{html.escape(title)}</title>", page, "title")
        page = replace(r'<meta name="description" content="[^"]*">', f'<meta name="description" content="{html.escape(description, quote=True)}">', page, "description")
        page = replace(r'<link rel="canonical" href="[^"]*">', f'<link rel="canonical" href="{url}">', page, "canonical")
        page = replace(r'<meta property="og:title" content="[^"]*">', f'<meta property="og:title" content="{html.escape(title, quote=True)}">', page, "og:title")
        page = replace(r'<meta property="og:description" content="[^"]*">', f'<meta property="og:description" content="{html.escape(description, quote=True)}">', page, "og:description")
        page = replace(r'<meta property="og:url" content="[^"]*">', f'<meta property="og:url" content="{url}">', page, "og:url")
        page = replace(r'<meta name="twitter:title" content="[^"]*">', f'<meta name="twitter:title" content="{html.escape(title, quote=True)}">', page, "twitter:title")
        page = replace(r'<meta name="twitter:description" content="[^"]*">', f'<meta name="twitter:description" content="{html.escape(description, quote=True)}">', page, "twitter:description")
        destination = root / route / "index.html"
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(page, encoding="utf-8")
        if f'href="{url}"' not in destination.read_text(encoding="utf-8"):
            raise RuntimeError(f"Canonical validation failed: {route}")

    # GitHub Pages serves this Flutter entry point for unknown/deep paths.
    # Keep the GitHub Pages 404 document out of search results.
    fallback = replace(r'<meta name="robots" content="[^"]*">',
                       '<meta name="robots" content="noindex, follow">', template, "robots")
    (root / "404.html").write_text(fallback, encoding="utf-8")
    print("Generated six route-specific SEO entry points and GitHub Pages 404 fallback.")

if __name__ == "__main__":
    main()

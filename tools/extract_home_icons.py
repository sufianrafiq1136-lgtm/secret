"""Extract home-screen icons from the reference screenshot."""

from __future__ import annotations

from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path(
    r"C:\Users\DELL\.cursor\projects\d-easypesa\assets"
    r"\c__Users_DELL_AppData_Roaming_Cursor_User_workspaceStorage_empty-window_images"
    r"_Home_sceen-80442a82-1ca9-4c4b-b91f-144b99e461e9.png"
)


def is_content_pixel(r: int, g: int, b: int, a: int = 255) -> bool:
    if a < 16:
        return False
    # Ignore near-white background and light mint header strip.
    if r > 245 and g > 245 and b > 245:
        return False
    if g > 210 and r < 40 and b < 140:
        return False
    return r + g + b < 720


def bbox_around(img: Image.Image, cx: int, cy: int, radius: int = 70) -> tuple[int, int, int, int] | None:
    pixels = img.load()
    w, h = img.size
    x0 = max(0, cx - radius)
    y0 = max(0, cy - radius)
    x1 = min(w, cx + radius)
    y1 = min(h, cy + radius)

    min_x, min_y, max_x, max_y = w, h, 0, 0
    found = False
    for y in range(y0, y1):
        for x in range(x0, x1):
            r, g, b, a = pixels[x, y]
            if is_content_pixel(r, g, b, a):
                found = True
                min_x = min(min_x, x)
                min_y = min(min_y, y)
                max_x = max(max_x, x)
                max_y = max(max_y, y)

    if not found:
        return None

    pad = 4
    return (
        max(0, min_x - pad),
        max(0, min_y - pad),
        min(w, max_x + pad + 1),
        min(h, max_y + pad + 1),
    )


def crop_icon(img: Image.Image, box: tuple[int, int, int, int], size: int = 96) -> Image.Image:
    cropped = img.crop(box)
    square = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    cw, ch = cropped.size
    scale = min(size / cw, size / ch)
    nw, nh = max(1, int(cw * scale)), max(1, int(ch * scale))
    resized = cropped.resize((nw, nh), Image.Resampling.LANCZOS)
    ox = (size - nw) // 2
    oy = (size - nh) // 2
    square.paste(resized, (ox, oy), resized)
    return square


def save_crop(img: Image.Image, center: tuple[int, int], dest: Path, *, size: int = 96, radius: int = 70) -> None:
    box = bbox_around(img, *center, radius=radius)
    if box is None:
        raise RuntimeError(f"No content found near {center} for {dest.name}")
    dest.parent.mkdir(parents=True, exist_ok=True)
    crop_icon(img, box, size=size).save(dest, optimize=True)
    print(f"saved {dest.relative_to(ROOT)} from {box}")


def main() -> None:
    img = Image.open(SOURCE).convert("RGBA")
    w, _ = img.size

    col4 = [w * 0.125, w * 0.375, w * 0.625, w * 0.875]
    col3 = [w * 0.165, w * 0.5, w * 0.835]

    # Header / branding
    save_crop(img, (int(w * 0.11), 52), ROOT / "assets/images/profile_avatar.png", size=128, radius=34)
    save_crop(img, (int(w * 0.5), 48), ROOT / "assets/logos/digital_bank_logo.png", size=160, radius=42)
    save_crop(img, (int(w * 0.23), 218), ROOT / "assets/icons/easypaisa_wallet_badge.png", size=64, radius=18)

    # Top quick actions
    quick_y = 318
    quick_icons = [
        ("send_money.png", col3[0]),
        ("bill_payment.png", col3[1]),
        ("mobile_packages.png", col3[2]),
    ]
    for name, cx in quick_icons:
        save_crop(img, (int(cx), quick_y), ROOT / "assets/icons" / name, size=112, radius=52)

    # More-with-easypaisa grid (4 x 3)
    grid_rows = [455, 535, 635]
    grid_names = [
        ["easyload.png", "easycash_loan.png", "savings_pocket.png", "invite_earn.png"],
        ["donations.png", "term_deposit.png", "daily_rewards.png", "buy_now_pay_later.png"],
        ["insurance_marketplace.png", "mtag.png", "rs1_game.png", "see_all.png"],
    ]
    for row_y, names in zip(grid_rows, grid_names):
        for cx, name in zip(col4, names):
            save_crop(img, (int(cx), row_y), ROOT / "assets/icons" / name, size=96, radius=44)


if __name__ == "__main__":
    main()

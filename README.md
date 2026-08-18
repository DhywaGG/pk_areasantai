## Dependencies

- qbx_core
- ox_lib
- Resource HUD/stress yang menyediakan event pengurangan stress, jika fitur stress digunakan.

## Perubahan dari versi lama

- Notifikasi menggunakan `ox_lib` (`lib.notify`).
- Framework ditetapkan sebagai Qbox.
- Zone dibuat menggunakan `ox_lib` poly zone.
- Support banyak relax zone.
- Zone otomatis dibersihkan ketika resource dihentikan.
- Debug zone default dimatikan.
- Integrasi stress dibuat configurable karena Qbox tidak memiliki sistem stress universal.

## Instalasi

1. Extract folder resource ke `resources/[standalone]/pk_areasantai`.
2. Pastikan `qbx_core` dan `ox_lib` sudah berjalan.
3. Tambahkan ke `server.cfg`:

```cfg
ensure ox_lib
ensure qbx_core
ensure pk_areasantai
```

## Integrasi Stress

Default config:

```lua
Config.Stress = {
    enabled = true,
    mode = 'server_event',
    event = 'hud:server:RelieveStress',
}
```

Jika HUD/stress resource kamu memakai event yang berbeda, ubah nilai `event` sesuai event resource tersebut.

Jika server kamu tidak menggunakan sistem stress:

```lua
Config.Stress = {
    enabled = false,
    mode = 'none',
    event = '',
}
```

## Menambah Relax Zone

Tambahkan object baru di `Config.Healing` dan isi `points` dengan koordinat polygon dari ox_lib.

Contoh:

```lua
{
    useblip = true,
    blip = {
        name = 'Zona Healing 2',
        coords = vector3(0.0, 0.0, 0.0),
        sprite = 197,
        scale = 0.7,
        color = 4,
    },
    points = {
        vec3(0.0, 0.0, 0.0),
        vec3(10.0, 0.0, 0.0),
        vec3(10.0, 10.0, 0.0),
        vec3(0.0, 10.0, 0.0),
    },
    thickness = 10.0,
    debug = false,
    WaitTick = 1000,
    JumlahStress = 10000,
},
```

## Catatan Qbox

Qbox (`qbx_core`) tidak menetapkan satu API stress yang wajib dipakai semua HUD. Karena itu resource ini tidak memaksakan metadata stress tertentu. Event stress dibuat configurable agar mengikuti HUD/stress system yang terpasang di server.


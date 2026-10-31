# Varlık Listesi (CC0 / CC-BY) — Sürdürülebilir Beslenme Macerası

Tüm öneriler ücretsiz ve ticari kullanıma uygun lisanslardadır. Format: GLB.
Sıkıştırma: gltf-transform ile Draco veya meshopt; doku: 1K (mobil), KTX2 önerilir.

## Model paketleri
| Kaynak | Paket | Lisans | Kullanım |
|---|---|---|---|
| Quaternius | Ultimate Food Pack | CC0 | Tüm meyve/sebze/baklagil/et/süt |
| Quaternius | Farm / Nature | CC0 | Tarla, sulama, çiftlik propları |
| Kenney | Food Kit | CC0 | Ambalaj, kutu, şişe, kavanoz |
| Kenney | Furniture Kit | CC0 | Tezgâh, raf, masa |
| Kenney | City Kit | CC0 | Market, kamyon, depo |
| Quaternius | Kitchen Props | CC0 | Mutfak, tabak, tencere |
| Sketchfab (CC0 filtresi) | Tekil modeller | CC0 | Eksik özel proplar |

## Doku paketleri (PBR: albedo + normal + roughness)
| Kaynak | Doku | Lisans |
|---|---|---|
| Poly Haven | wood_planks, dirt, grass, stone, fabric, metal, plastic | CC0 |
| ambientCG | Wood, Ground, Fabric, Metal | CC0 |

## Bölüm → varlık eşlemesi (poly hedefi)
1. Bitkisel Protein — mercimek/nohut/fasulye/et/yumurta · Quaternius Food · 300–800 tri
2. Mevsim — çilek/enginar/karpuz/domates/elma/üzüm/portakal/ıspanak · Quaternius Fruit+Veg · 250–700
3. Yerel Ürün — domates/salatalık/biber/avokado/muz/kivi + tezgâh · Quaternius + Kenney Furniture · 400–900
4. Besinin Yolculuğu — kasa, kamyon, depo, market · Kenney City/Quaternius · 500–1500
5. Biyoçeşitlilik — buğday/arpa/mercimek/nohut/domates/biber · Quaternius · 250–700
6. Bütçe — ekmek/mercimek/sebze/elma/süt/tavuk/cips/kola/dondurma · Quaternius Food · 300–900
7. Ambalaj — şişe/karton/kavanoz/poşet/pipet · Kenney Food Kit · 200–500
8. İsraf — domates/yoğurt/marul/ekmek/süt · Quaternius · 250–700
9. Gıda Kurtarıcısı — ekmek/domates/peynir + tencere · Quaternius Kitchen · 400–900
10. Tabak — brokoli/elma/mercimek/bulgur + tabak · Quaternius · 300–800
11. Kantin — salata/sandviç/çorba/meyve/kek/kola · Quaternius Food · 300–900
12. Su — sulama fıskiyesi/damlama boruları · Quaternius Farm · 400–1000

## Performans bütçesi
- Sahne toplamı: < 60.000 üçgen
- Tek öğe: 200–1.500 üçgen
- Malzeme: paket başına 1 atlas (tek draw call hedefi)
- Doku: 1024², KTX2 + mipmap
- Işık: 3 (hemisphere + directional + point) — kodda uygulandı
- Gölge: 1024² PCFSoft, directional shadow max 14 birim
- Sis: 24–54 birim derinlik (kodda)
- AO: gerçek SSAO yerine ucuz "blob shadow" (kodda)

## Not (mevcut kod)
Kod şu an prosedürel low-poly geometri + canvas PBR doku üretir (CDN dışında
bağımlılık yok, tek dosya çalışır). Gerçek GLB'leri bağlamak için level
tanımlarındaki öğelere "model" alanı eklenip GLTFLoader ile yüklenebilir;
kod bunun için hazır (GLTFLoader import edilmiş).

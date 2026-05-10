-- =========================================
-- 1. CONTAGEM TOTAL
-- =========================================

SELECT 
    COUNT(*) AS Total_Faixas,
    COUNT(DISTINCT ID_Album) AS Total_Albuns
FROM faixas;


-- =========================================
-- 2. VALORES NULOS
-- =========================================

SELECT 
    SUM(CASE WHEN ID_Faixa IS NULL THEN 1 ELSE 0 END) AS Nulos_ID_Faixa,
    SUM(CASE WHEN ID_Album IS NULL THEN 1 ELSE 0 END) AS Nulos_ID_Album,
    SUM(CASE WHEN Título_Faixa IS NULL THEN 1 ELSE 0 END) AS Nulos_Titulo,
    SUM(CASE WHEN Duração_Segundos IS NULL THEN 1 ELSE 0 END) AS Nulos_Duracao,
    SUM(CASE WHEN Danceability IS NULL THEN 1 ELSE 0 END) AS Nulos_Danceability,
    SUM(CASE WHEN Valence IS NULL THEN 1 ELSE 0 END) AS Nulos_Valence
FROM faixas;


-- =========================================
-- 3. ESTATÍSTICAS DESCRITIVAS
-- =========================================

SELECT 
    'Duração_Segundos' AS Metrica,
    MIN(Duração_Segundos) AS Minimo,
    MAX(Duração_Segundos) AS Maximo,
    AVG(Duração_Segundos) AS Media,
    STDEV(Duração_Segundos) AS Desvio_Padrao
FROM faixas

UNION ALL

SELECT 
    'Danceability',
    MIN(Danceability),
    MAX(Danceability),
    AVG(Danceability),
    STDEV(Danceability)
FROM faixas

UNION ALL

SELECT 
    'Valence',
    MIN(Valence),
    MAX(Valence),
    AVG(Valence),
    STDEV(Valence)
FROM faixas;


-- =========================================
-- 4. DISTRIBUIÇÃO POR DURAÇÃO
-- =========================================

SELECT 
    CASE 
        WHEN Duração_Segundos < 180 THEN 'Menos de 3min'
        WHEN Duração_Segundos BETWEEN 180 AND 300 THEN '3-5min'
        WHEN Duração_Segundos BETWEEN 301 AND 420 THEN '5-7min'
        ELSE 'Mais de 7min'
    END AS Faixa_Duracao,

    COUNT(*) AS Quantidade,

    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM faixas),
        2
    ) AS Percentual

FROM faixas
GROUP BY 
    CASE 
        WHEN Duração_Segundos < 180 THEN 'Menos de 3min'
        WHEN Duração_Segundos BETWEEN 180 AND 300 THEN '3-5min'
        WHEN Duração_Segundos BETWEEN 301 AND 420 THEN '5-7min'
        ELSE 'Mais de 7min'
    END
ORDER BY Quantidade DESC;


-- =========================================
-- 5. ÁLBUNS COM MAIS FAIXAS
-- =========================================

SELECT TOP 10
    ID_Album,
    COUNT(*) AS Total_Faixas,
    AVG(Duração_Segundos) AS Media_Duracao,
    AVG(Danceability) AS Media_Danceability,
    AVG(Valence) AS Media_Valence
FROM faixas
GROUP BY ID_Album
ORDER BY Total_Faixas DESC;


-- =========================================
-- 6. MAIOR DANCEABILITY MÉDIA
-- =========================================

SELECT TOP 10
    ID_Album,
    COUNT(*) AS Total_Faixas,
    ROUND(AVG(Danceability), 3) AS Media_Danceability,
    ROUND(AVG(Valence), 3) AS Media_Valence
FROM faixas
GROUP BY ID_Album
HAVING COUNT(*) >= 3
ORDER BY Media_Danceability DESC;


-- =========================================
-- 7. MAIOR VALENCE MÉDIA
-- =========================================

SELECT TOP 10
    ID_Album,
    COUNT(*) AS Total_Faixas,
    ROUND(AVG(Valence), 3) AS Media_Valence,
    ROUND(AVG(Danceability), 3) AS Media_Danceability
FROM faixas
GROUP BY ID_Album
HAVING COUNT(*) >= 3
ORDER BY Media_Valence DESC;


-- =========================================
-- 8. CORRELAÇÃO DANCEABILITY x VALENCE
-- =========================================

SELECT 
    ROUND(
        (
            COUNT(*) * SUM(Danceability * Valence)
            - SUM(Danceability) * SUM(Valence)
        )
        /
        (
            SQRT(
                COUNT(*) * SUM(Danceability * Danceability)
                - SUM(Danceability) * SUM(Danceability)
            )
            *
            SQRT(
                COUNT(*) * SUM(Valence * Valence)
                - SUM(Valence) * SUM(Valence)
            )
        ),
    4) AS Correlacao_Danceability_Valence
FROM faixas;


-- =========================================
-- 9. CORRELAÇÃO DURAÇÃO x DANCEABILITY
-- =========================================

SELECT 
    ROUND(
        (
            COUNT(*) * SUM(Duração_Segundos * Danceability)
            - SUM(Duração_Segundos) * SUM(Danceability)
        )
        /
        (
            SQRT(
                COUNT(*) * SUM(Duração_Segundos * Duração_Segundos)
                - SUM(Duração_Segundos) * SUM(Duração_Segundos)
            )
            *
            SQRT(
                COUNT(*) * SUM(Danceability * Danceability)
                - SUM(Danceability) * SUM(Danceability)
            )
        ),
    4) AS Correlacao_Duracao_Danceability
FROM faixas;

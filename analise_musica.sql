-- 1. CONTAGEM TOTAL DE FAIXAS E ÁLBUNS
SELECT
    COUNT(*) AS Total_Faixas,
    COUNT(DISTINCT ID_Album) AS Total_Albuns
[span_2](start_span)FROM faixas;[span_2](end_span)

-- 2. VERIFICAÇÃO DE VALORES NULOS
SELECT
    COUNT(ID_Album) AS Nulos_ID_Album,
    COUNT(Título_Faixa) AS Nulos_Titulo,
    COUNT(ID_Faixa) AS Nulos_ID_Faixa,
    COUNT(Duração_Segundos) AS Nulos_Duracao,
    COUNT(Danceability) AS Nulos_Danceability,
    COUNT(Valence) AS Nulos_Valence
[span_3](start_span)FROM faixas;[span_3](end_span)

-- 3. ESTATÍSTICAS DESCRITIVAS
SELECT
    'Duração_Segundos' AS Metrica,
    MIN(Duração_Segundos) AS Minimo,
    MAX(Duração_Segundos) AS Maximo,
    AVG(Duração_Segundos) AS Media
FROM faixas
UNION ALL
SELECT 'Danceability', MIN(Danceability), MAX(Danceability), AVG(Danceability) FROM faixas
UNION ALL
[span_4](start_span)SELECT 'Valence', MIN(Valence), MAX(Valence), AVG(Valence) FROM faixas;[span_4](end_span)

-- 4. DISTRIBUIÇÃO POR DURAÇÃO
SELECT
    CASE
        WHEN Duração_Segundos < 180 THEN 'Menos de 3min'
        WHEN Duração_Segundos BETWEEN 180 AND 300 THEN '3-5min'
        WHEN Duração_Segundos BETWEEN 301 AND 420 THEN '5-7min'
        ELSE 'Mais de 7min'
    END AS Faixa_Duracao,
    COUNT(*) AS Quantidade,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM faixas), 2) AS Percentual
FROM faixas
GROUP BY 1
[span_5](start_span)ORDER BY Quantidade DESC;[span_5](end_span)

-- 5. ÁLBUNS COM MAIS FAIXAS E MÉDIAS TÉCNICAS
SELECT
    ID_Album,
    COUNT(*) AS Total_Faixas,
    AVG(Duração_Segundos) AS Media_Duracao,
    AVG(Danceability) AS Media_Danceability,
    AVG(Valence) AS Media_Valence
FROM faixas
GROUP BY ID_Album
ORDER BY Total_Faixas DESC
[span_6](start_span)LIMIT 10;[span_6](end_span)

-- 6. ATUALIZAÇÕES (DATA MANIPULATION)
-- Aumento de 10% na duração das faixas
UPDATE faixas 
[span_7](start_span)SET Duração_Segundos = Duração_Segundos * 1.10;[span_7](end_span)

-- 7. CLASSIFICAÇÃO DE ENERGIA E RITMO
-- Exemplo de query para o exercício 10
SELECT 
    Título_Faixa,
    Danceability,
    CASE 
        WHEN Danceability > 0.7 THEN 'Alta Energia'
        ELSE 'Ritmo Moderado'
    END AS Classificacao
[span_8](start_span)FROM faixas;[span_8](end_span)

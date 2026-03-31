-- ============================================================
--  PET SHOP — UPDATE & DELETE
--  UUIDs corrigidos: apenas caracteres hex válidos (0-9, a-f)
-- ============================================================

-- ============================================================
-- UPDATE
-- ============================================================

-- [U1] Venda aberta → concluída
UPDATE venda SET status = 'concluida'
WHERE id = 'f1000000-0000-0000-0000-000000000003';

-- [U2] Venda aberta → cancelada
UPDATE venda SET status = 'cancelada'
WHERE id = 'f1000000-0000-0000-0000-000000000005';

-- [U3] Reajuste de preço do produto em 10%
UPDATE produto SET preco = ROUND(preco * 1.10, 2)
WHERE id = 'd1000000-0000-0000-0000-000000000001';

-- [U4] Baixa de estoque após venda confirmada
UPDATE produto SET quantidade = quantidade - 2
WHERE id = 'd1000000-0000-0000-0000-000000000001';

-- [U5] Corrigir email do cliente
UPDATE cliente SET email = 'ana.nova@email.com'
WHERE id = 'c1000000-0000-0000-0000-000000000001';

-- [U6] Atendente "vira" cliente — vincula cliente_id
UPDATE atendente SET cliente_id = 'c1000000-0000-0000-0000-000000000001'
WHERE id = 'a2000000-0000-0000-0000-000000000001';

-- [U7] Reajuste de preço de serviço
UPDATE servico SET preco = 140.00
WHERE id = 'e1000000-0000-0000-0000-000000000001';

-- [U8] Renomear produto
UPDATE produto SET nome = 'Ração Super Premium 15kg'
WHERE id = 'd1000000-0000-0000-0000-000000000001';

-- [U9] Transferir animal para outro cliente (adoção)
UPDATE animal SET cliente_id = 'c1000000-0000-0000-0000-000000000002'
WHERE id = 'a1000000-0000-0000-0000-000000000006';

-- ============================================================
-- DELETE
-- ============================================================

-- [D1] Remover item de produto de venda cancelada
DELETE FROM venda_produto
WHERE venda_id   = 'f1000000-0000-0000-0000-000000000004'
  AND produto_id = 'd1000000-0000-0000-0000-000000000006';

-- [D2] Remover vínculo de serviço com tosador
DELETE FROM servico_tosador
WHERE servico_id = 'e1000000-0000-0000-0000-000000000003'
  AND tosador_id = 'b2000000-0000-0000-0000-000000000002';

-- [D3] Remover vínculo de animal com atendente
DELETE FROM animal_atendente
WHERE animal_id    = 'a1000000-0000-0000-0000-000000000009'
  AND atendente_id = 'a2000000-0000-0000-0000-000000000001';

-- [D4] Deletar venda cancelada (CASCADE remove venda_produto e venda_servico)
DELETE FROM venda
WHERE id = 'f1000000-0000-0000-0000-000000000004' AND status = 'cancelada';

-- [D5] Deletar animal sem vínculos (vínculo removido em D3)
DELETE FROM animal
WHERE id = 'a1000000-0000-0000-0000-000000000009';

-- ---------------------------------------------------------------
-- TESTES DE RESTRIÇÃO — descomente 1 por vez para validar
-- ---------------------------------------------------------------

-- [D6] RESTRICT → produto com venda ativa — espera ERROR de FK
-- DELETE FROM produto WHERE id = 'd1000000-0000-0000-0000-000000000002';

-- [D7] RESTRICT → atendente com venda vinculada — espera ERROR de FK
-- DELETE FROM atendente WHERE id = 'a2000000-0000-0000-0000-000000000002';

-- [D8] CASCADE → deletar cliente remove seus animais automaticamente
-- DELETE FROM cliente WHERE id = 'c1000000-0000-0000-0000-000000000004';


-- ============================================================
-- VERIFICAÇÃO FINAL — contagem por tabela
-- ============================================================
SELECT 'cliente'              AS tabela, COUNT(*) AS total FROM cliente
UNION ALL SELECT 'animal',              COUNT(*) FROM animal
UNION ALL SELECT 'atendente',           COUNT(*) FROM atendente
UNION ALL SELECT 'veterinario',         COUNT(*) FROM veterinario
UNION ALL SELECT 'tosador',             COUNT(*) FROM tosador
UNION ALL SELECT 'produto',             COUNT(*) FROM produto
UNION ALL SELECT 'servico',             COUNT(*) FROM servico
UNION ALL SELECT 'venda',               COUNT(*) FROM venda
UNION ALL SELECT 'animal_atendente',    COUNT(*) FROM animal_atendente
UNION ALL SELECT 'venda_produto',       COUNT(*) FROM venda_produto
UNION ALL SELECT 'venda_servico',       COUNT(*) FROM venda_servico
UNION ALL SELECT 'servico_veterinario', COUNT(*) FROM servico_veterinario
UNION ALL SELECT 'servico_tosador',     COUNT(*) FROM servico_tosador
ORDER BY tabela;
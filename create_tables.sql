-- ============================================================
--  PET SHOP SCHEMA — PostgreSQL
-- ============================================================
-- Extensão para UUID
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- 1. CLIENTE
-- ============================================================
CREATE TABLE CLIENTE (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	NOME VARCHAR(150) NOT NULL,
	EMAIL VARCHAR(255),
	CPF CHAR(11) NOT NULL UNIQUE,
	CRIADO_EM TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 2. ANIMAL
-- (campo "email" mantido conforme diagrama — pode ser contato)
-- ============================================================
CREATE TABLE ANIMAL (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	NOME VARCHAR(100) NOT NULL,
	CLIENTE_ID UUID NOT NULL REFERENCES CLIENTE (ID) ON DELETE CASCADE,
	CRIADO_EM TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 3. ATENDENTE
-- ============================================================
CREATE TABLE ATENDENTE (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	NOME VARCHAR(150) NOT NULL,
	CPF CHAR(11) NOT NULL UNIQUE,
	CLIENTE_ID UUID -- pode virar cliente
	REFERENCES CLIENTE (ID) ON DELETE SET NULL,
	CRIADO_EM TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 4. VETERINARIO
-- ============================================================
CREATE TABLE VETERINARIO (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	NOME VARCHAR(150) NOT NULL,
	CPF CHAR(11) NOT NULL UNIQUE,
	CLIENTE_ID UUID -- pode virar cliente
	REFERENCES CLIENTE (ID) ON DELETE SET NULL,
	CRIADO_EM TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 5. TOSADOR
-- ============================================================
CREATE TABLE TOSADOR (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	NOME VARCHAR(150) NOT NULL,
	CPF CHAR(11) NOT NULL UNIQUE,
	CLIENTE_ID UUID -- pode virar cliente
	REFERENCES CLIENTE (ID) ON DELETE SET NULL,
	CRIADO_EM TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 6. PRODUTO
-- ============================================================
CREATE TABLE PRODUTO (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	NOME VARCHAR(200) NOT NULL,
	PRECO NUMERIC(10, 2) NOT NULL CHECK (PRECO >= 0),
	QUANTIDADE INTEGER NOT NULL DEFAULT 0 CHECK (QUANTIDADE >= 0),
	CRIADO_EM TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- 7. SERVIÇO
-- ============================================================
CREATE TABLE SERVICO (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	TIPO VARCHAR(100) NOT NULL,
	PRECO NUMERIC(10, 2) NOT NULL CHECK (PRECO >= 0)
);

-- ============================================================
-- 8. VENDA
-- ============================================================
CREATE TABLE VENDA (
	ID UUID PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
	ORDER_DATE DATE NOT NULL DEFAULT CURRENT_DATE,
	STATUS VARCHAR(50) NOT NULL DEFAULT 'aberta' CHECK (STATUS IN ('aberta', 'concluida', 'cancelada')),
	ATENDENTE_ID UUID NOT NULL REFERENCES ATENDENTE (ID) ON DELETE RESTRICT,
	CRIADO_EM TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- TABELAS DE JUNÇÃO
-- ============================================================
-- Animal ↔ Atendente  (animal recebe atendimento de atendentes)
CREATE TABLE ANIMAL_ATENDENTE (
	ANIMAL_ID UUID NOT NULL REFERENCES ANIMAL (ID) ON DELETE CASCADE,
	ATENDENTE_ID UUID NOT NULL REFERENCES ATENDENTE (ID) ON DELETE CASCADE,
	PRIMARY KEY (ANIMAL_ID, ATENDENTE_ID)
);

-- Venda ↔ Produto  (itens de produto em uma venda)
CREATE TABLE VENDA_PRODUTO (
	VENDA_ID UUID NOT NULL REFERENCES VENDA (ID) ON DELETE CASCADE,
	PRODUTO_ID UUID NOT NULL REFERENCES PRODUTO (ID) ON DELETE RESTRICT,
	QUANTIDADE INTEGER NOT NULL DEFAULT 1 CHECK (QUANTIDADE > 0),
	PRECO_UNIT NUMERIC(10, 2) NOT NULL CHECK (PRECO_UNIT >= 0),
	PRIMARY KEY (VENDA_ID, PRODUTO_ID)
);

-- Venda ↔ Serviço  (itens de serviço em uma venda)
CREATE TABLE VENDA_SERVICO (
	VENDA_ID UUID NOT NULL REFERENCES VENDA (ID) ON DELETE CASCADE,
	SERVICO_ID UUID NOT NULL REFERENCES SERVICO (ID) ON DELETE RESTRICT,
	PRIMARY KEY (VENDA_ID, SERVICO_ID)
);

-- Serviço ↔ Veterinário  (serviço atendido por veterinário)
CREATE TABLE SERVICO_VETERINARIO (
	SERVICO_ID UUID NOT NULL REFERENCES SERVICO (ID) ON DELETE CASCADE,
	VETERINARIO_ID UUID NOT NULL REFERENCES VETERINARIO (ID) ON DELETE RESTRICT,
	PRIMARY KEY (SERVICO_ID, VETERINARIO_ID)
);

-- Serviço ↔ Tosador  (serviço atendido por tosador)
CREATE TABLE SERVICO_TOSADOR (
	SERVICO_ID UUID NOT NULL REFERENCES SERVICO (ID) ON DELETE CASCADE,
	TOSADOR_ID UUID NOT NULL REFERENCES TOSADOR (ID) ON DELETE RESTRICT,
	PRIMARY KEY (SERVICO_ID, TOSADOR_ID)
);

-- ============================================================
-- ÍNDICES DE PERFORMANCE
-- ============================================================
CREATE INDEX IDX_ANIMAL_CLIENTE ON ANIMAL (CLIENTE_ID);

CREATE INDEX IDX_ATENDENTE_CLIENTE ON ATENDENTE (CLIENTE_ID);

CREATE INDEX IDX_VETERINARIO_CLIENTE ON VETERINARIO (CLIENTE_ID);

CREATE INDEX IDX_TOSADOR_CLIENTE ON TOSADOR (CLIENTE_ID);

CREATE INDEX IDX_VENDA_ATENDENTE ON VENDA (ATENDENTE_ID);

CREATE INDEX IDX_VENDA_ORDER_DATE ON VENDA (ORDER_DATE);
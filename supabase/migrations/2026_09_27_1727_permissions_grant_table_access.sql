-- 2026_09_27_1727_permissions_grant_table_access.sql
-- Grant table and schema privileges to authenticated, service_role, and anon.
-- Fixes "permission denied for table accounts" and "permission denied for table whatsapp_config"
-- by allowing PostgREST roles to access tables governed by Row Level Security (RLS).

-- 1. Schema usage
GRANT USAGE ON SCHEMA public TO anon, authenticated, service_role;

-- 2. Table permissions
-- Authenticated users: standard CRUD access (governed by table RLS policies)
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO authenticated;

-- Service role: full access (bypasses RLS)
GRANT ALL ON ALL TABLES IN SCHEMA public TO service_role;

-- Anon users: read-only access where RLS policies permit (no public write access)
GRANT SELECT ON ALL TABLES IN SCHEMA public TO anon;

-- 3. Sequences
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO authenticated, service_role;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO anon;

-- 4. Preserve column-level security restrictions (migration 027)
REVOKE UPDATE ON public.notifications FROM authenticated;
GRANT UPDATE (read_at) ON public.notifications TO authenticated;

-- 5. Default privileges for future tables/sequences created in public schema
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO anon;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO authenticated, service_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON SEQUENCES TO anon;

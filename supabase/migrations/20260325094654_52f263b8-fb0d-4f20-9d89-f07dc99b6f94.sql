-- Add FK so suggestions can reliably join profiles by user_id
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'suggestions_user_id_profiles_fkey'
      AND conrelid = 'public.suggestions'::regclass
  ) THEN
    ALTER TABLE public.suggestions
      ADD CONSTRAINT suggestions_user_id_profiles_fkey
      FOREIGN KEY (user_id)
      REFERENCES public.profiles(id)
      ON DELETE CASCADE;
  END IF;
END $$;

-- Optional downloadable file URL fields
ALTER TABLE public.games ADD COLUMN IF NOT EXISTS download_url text;
ALTER TABLE public.news ADD COLUMN IF NOT EXISTS download_url text;

-- Public storage bucket for downloadable files
INSERT INTO storage.buckets (id, name, public)
SELECT 'downloads', 'downloads', true
WHERE NOT EXISTS (
  SELECT 1 FROM storage.buckets WHERE id = 'downloads'
);

-- Storage policies
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'storage' AND tablename = 'objects' AND policyname = 'Public can view download files'
  ) THEN
    CREATE POLICY "Public can view download files"
    ON storage.objects
    FOR SELECT
    USING (bucket_id = 'downloads');
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'storage' AND tablename = 'objects' AND policyname = 'Admins can upload download files'
  ) THEN
    CREATE POLICY "Admins can upload download files"
    ON storage.objects
    FOR INSERT
    WITH CHECK (bucket_id = 'downloads' AND public.has_role(auth.uid(), 'admin'));
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'storage' AND tablename = 'objects' AND policyname = 'Admins can update download files'
  ) THEN
    CREATE POLICY "Admins can update download files"
    ON storage.objects
    FOR UPDATE
    USING (bucket_id = 'downloads' AND public.has_role(auth.uid(), 'admin'));
  END IF;

  IF NOT EXISTS (
    SELECT 1 FROM pg_policies
    WHERE schemaname = 'storage' AND tablename = 'objects' AND policyname = 'Admins can delete download files'
  ) THEN
    CREATE POLICY "Admins can delete download files"
    ON storage.objects
    FOR DELETE
    USING (bucket_id = 'downloads' AND public.has_role(auth.uid(), 'admin'));
  END IF;
END $$;
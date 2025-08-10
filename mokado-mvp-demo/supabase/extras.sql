
-- Optional helper to generate bcrypt hash from client (not recommended for prod; use server)
create or replace function public.gen_hash(raw text)
returns text language sql security definer set search_path = public as $$
  select crypt(raw, gen_salt('bf'));
$$;

-- Count transactions in time windows for owner analytics
create or replace function public.count_tx(cafe uuid, win text)
returns int language sql security definer set search_path = public as $$
  select count(*)::int from transactions
  where cafe_id = cafe and
    case
      when win = 'day' then created_at > now() - interval '1 day'
      when win = 'week' then created_at > now() - interval '7 days'
      when win = 'month' then created_at > now() - interval '30 days'
      else true
    end;
$$;

-- Allow owners to call count_tx
revoke all on function public.count_tx(uuid, text) from public;
grant execute on function public.count_tx(uuid, text) to authenticated;

-- Allow authenticated users to call award/redeem/balance/gen_hash
grant execute on function public.award_point(uuid, text) to authenticated;
grant execute on function public.redeem_reward(uuid) to authenticated;
grant execute on function public.balance_for(uuid) to authenticated;
grant execute on function public.gen_hash(text) to authenticated;

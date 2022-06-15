# Finding the right timing for the reset glitch hack

## Getting memcmp POST length in ticks

First step is to know how long the memcmp POST will last while slowed
down. No reset pulse should be sent for this. Using hardware that can
read the POST bus and measure time in a precise way, measure the time
between memcmp POST start and 'hash compare failed' final POST (eg on
fats, between POST 39 and POST AD) with the next bootloader failing hash
check.

An ARM7 based Olimex LPC-H2148 was used for this task.

It could look like that:

```c
for(;;)
{
  post = post_read();
  if (post == prev_post) then continue;

  if(post == MEMCMP_POST)
  {
    t_start = get_tick();

    while( post_read() == MEMCMP_POST );

    memcmp_post_length=get_tick()-t_start;

    print(memcmp_post_length);
  }

  prev_post=post;
}
```

Make sure you note memcmp post length ;)

## Using random timing over the full POST length

Now you need the hardware to send a reset pulse after a random amount of
time in memcmp POST, but no more than previously found memcmp POST
length.

It could look like that:

```c
for(;;)
{
  post = read_post();
  if (post == prev_post) then continue;

  if(post == MEMCMP_POST)
  {
    t_start = get_tick();
    t_rand = rand() % MEMCMP_POST_LENGTH;

    while( get_tick()< t_start+t_rand );

    ppc_send_reset_pulse();

    print(t_rand);
  }

  prev_post=post;
}
```

Using a hacked smc that reboots infinitely it will take a good amount of
time, but it should end up glitching properly.

Make sure you note the timing that glitched ;)

## Refining the timing, accounting for bell-like curve

So now we have one timing that glitches, but we don't know if it's
really the 'sweet spot' or if we were just lucky. What needs to be done
now is to get the timing of some more successes, I think it's safe to
use a smaller random range around previously found glitch timing. my
get_tick() function runs at 60Mhz, I found it was safe to make the
range -+50 ticks around previously found glitch timing

It could look like that:

```c
for(;;)
{
  post = read_post();
  if (post == prev_post) then continue;

  if(post == MEMCMP_POST)
  {
    t_start = get_tick();
    t_rand = PREV_GLITCH_TIMING - 50 + (rand() % 100);

    while( get_tick()< t_start+t_rand );

    ppc_send_reset_pulse();

    print(t_rand);
  }

  prev_post=post;
}
```

You'll need the timing of at least 20-30 successes. Averaging those
timings should give you the sweet spot (aka final timing), because
empirically we found that success rate vs timing is a bell-like curve.

Make sure ... you got it ;)

PS: Those pseudo-code examples don't show the slowdown code for the sake
of clarity.

[Category: Development](/Development)

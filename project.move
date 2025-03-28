module MyModule::AILeaderboard {

    use aptos_framework::signer;

    struct Leaderboard has store, key {
        top_score: u64,
        top_scorer: address,
    }

    /// Initializes the leaderboard with default values.
    public fun init_leaderboard(owner: &signer) {
        let leaderboard = Leaderboard {
            top_score: 0,
            top_scorer: signer::address_of(owner),
        };
        move_to(owner, leaderboard);
    }

    /// Function to submit a new score. Updates the leaderboard if it's the highest.
    public fun submit_score(player: &signer, score: u64) acquires Leaderboard {
        let leaderboard = borrow_global_mut<Leaderboard>(signer::address_of(player));
        if (score > leaderboard.top_score) {
            leaderboard.top_score = score;
            leaderboard.top_scorer = signer::address_of(player);
        }
    }
}

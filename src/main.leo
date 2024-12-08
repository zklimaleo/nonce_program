// The 'nonce_program' program.
import credits.aleo;

program nonce_program.aleo {
    mapping current_nonce: address => u128;

    async transition transfer_public(
        public recipient: address,
        public amount: u64,
        public nonce: u128
    ) -> Future {
        let f: Future = credits.aleo/transfer_public_as_signer(recipient, amount);
        return transfer_public_finalize(nonce,  self.caller, f);
    }

    async function transfer_public_finalize(
        public nonce: u128,
        public caller: address,
        public f: Future,
    ) {
        f.await();

        let nonce_last: u128 = current_nonce.get_or_use(caller, 0u128);
        let nonce_next: u128 = nonce_last + 1u128;

        assert_eq(nonce, nonce_last);
        current_nonce.set(caller, nonce_next);
    }
}

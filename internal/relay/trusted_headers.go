package relay

import (
	"context"
	"github.com/cosmos/ibc-go/v3/modules/core/exported"

	codectypes "github.com/cosmos/cosmos-sdk/codec/types"
)

// TrustedHeaderFetcher able to get trusted headers for a given height
type TrustedHeaderFetcher interface {
	// Fetch returns two trusted Headers for height and height+1 packed into *codectypes.Any value
	Fetch(ctx context.Context, height uint64) (header *codectypes.Any, nextHeader *codectypes.Any, err error)
	FetchBest(ctx context.Context, height uint64) (exported.Header, error)
}

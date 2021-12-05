#include<stdio.h>

int max(int n, int nums[]) {
		if (n == 0)
				return 0;
		int m = nums[0];
		for (int i = 1; i<n; i++)
				if (nums[i] > m)
						m = nums[i];
		return m;
}

int solve(int n, int nums[], int m) {
		int S = 0;
		for (int i = 0; i<n; i++)
				S += m-nums[i];
		return S;
}

int main() {
		int n;
		scanf("%d", &n);
		int nums[n];
		for (int i = 0; i<n; i++)
				scanf("%d", &nums[i]);
		printf("%d", solve(n, nums, max(n, nums)));
		return 0;
}

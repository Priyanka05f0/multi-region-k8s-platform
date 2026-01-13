# Operations Runbook

## Normal Operations
- Monitor system health using Prometheus and Grafana.
- Deployments are managed via GitOps.

## Disaster Recovery
- If one region fails, traffic is routed to healthy regions.
- Database replication ensures minimal data loss.

### Recovery Targets
- RTO: 5 minutes
- RPO: < 1 minute
